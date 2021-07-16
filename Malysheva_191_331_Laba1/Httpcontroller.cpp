#include "Httpcontroller.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QDebug>
#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QtWidgets/QTableView>
#include <QCryptographicHash>
#include <model.h>


Httpcontroller::Httpcontroller(QObject *QMLObject) : pocaz(QMLObject)
{
    nam = new QNetworkAccessManager(this); // создаем менеджер
    //  connect(nam, &QNetworkAccessManager::finished, this, &HttpController::SlotFinished);
    connect(nam, &QNetworkAccessManager::finished, this, &Httpcontroller::onNetworkValue);
    app_model = new Model();
}


void Httpcontroller::getNetworkValue()
{ // запрос к сайту

    QNetworkRequest request;
    request.setUrl(QUrl("https://yandex.ru/pogoda/moscow"));
    qDebug() << request.url();
    QNetworkReply * reply;
    QEventLoop evntLoop;
    connect(nam, &QNetworkAccessManager::finished, &evntLoop, &QEventLoop::quit);
    reply = nam->get(request);
    evntLoop.exec();
    QString replyString = reply->readAll();
    // emit signalSendToQML(QString(replyString));

}

void Httpcontroller::onNetworkValue(QNetworkReply *reply)
{ // парсинг сайта

     QString str = reply->readAll(); // записывем в str наш сайт
     QObject* textField = pocaz->findChild<QObject*>("textField"); // ищем элемент textField, куда буем записывать
    // QObject* textFieldDate = pocaz->findChild<QObject*>("textFieldDate");
     QObject* textArea = pocaz->findChild<QObject*>("textArea"); // ищем элемент textArea, откуда будем брать

     textArea->setProperty("text", str); // задаем параметр "текст" для textArea из qml

     int j = 0;

      if((j = str.indexOf("temp fact__temp fact__temp_size_s", j)) != -1) // ищем индекс этого тега в тексте
      {
         textField->setProperty("text", str.mid( j + 140,2)); // мы находим 140 символ после тега и отсчитываем 2 символов и их выводим (курс доллара) и записываем в textField
         //textFieldDate->setProperty("text", str.mid( j + 115,3)); // мы находим 115 символ после тега и отсчитываем 3 символов и их выводим (дату) и записываем в textFieldDate
      }
}


bool Httpcontroller::failed (QString add){

    qDebug() <<  "failed";
    if(add.indexOf("st._hi=") != -1)
    {
        QString pop;
        pop = add.split("st._hi=")[1].split(" ")[0];
          return 1;
    }
    else {
          return 0;
    }
     return 0;
}

bool Httpcontroller::cancel (QString add){
qDebug() <<  "failedcancel";
    if(add.indexOf("error=") != -1)
    {
      QString pop;
        pop = add.split("error=")[1].split(" ")[0];

       return 1;
    }
    else {
        return 0;
    }
   return 0;
}

void Httpcontroller::hashvd(QString add){
    qDebug() <<  "failed_hashvd";
    if (add.indexOf("session_secret_key=") != -1) // условие если он найден то записать в переменну
      {
           secret = add.split("session_secret_key=")[1].split("&")[0]; //запись в переменную токена
           qDebug() << "Секртеный ключ: " << secret;
           QString param = "application_key=CQAKJNJGDIHBABABAcount=10format=jsonmethod=photos.getPhotos"+secret;
              qDebug() << "Наш параметр" << param;
           QByteArray array;
          array.append(param);
           qDebug() << "Наш массив" << array;
           hash = QString(QCryptographicHash::hash((array),QCryptographicHash::Md5).toHex());
           qDebug() << "Наш хеш" << hash;
      }
      else{
          qDebug() << "Ошибка";


      }
}

QString Httpcontroller::success (QString add){ // функия для вывода access_token

    qDebug() <<  "success";
    if (add.indexOf("access_token=") != -1) // условие если он найден то записать в переменну
      {
           acctoken = add.split("access_token=")[1].split("&")[0]; //запись в переменную токена
           qDebug() << "Наш токен: " << acctoken;
           return acctoken;
      }
      else{
          qDebug() << "Ошибка";


      }

    QString str = " ";
    return str;
}

void Httpcontroller::restRequest(){
//qDebug() <<  "restre";
    QEventLoop loop;
    nam = new QNetworkAccessManager();

    QObject::connect(nam, // связываем loop  с нашим менеджером
                     SIGNAL(finished(QNetworkReply*)),
                     &loop,
                     SLOT(quit()));
//qDebug() << "hash" << hash;
//qDebug() << "actok" << acctoken;

    QNetworkReply *reply = nam->get(QNetworkRequest(QUrl( "https://api.vk.com/method/friends.get?v=5.52&fields=photo_100,city,status,domain,sex"
                                                          "&sig="+ hash +
                                                          "&access_token="+ acctoken )));
//qDebug() << "nam" << nam;

    loop.exec();

//    // вся строка JSON с сервера грузится в QJsonDocument
      QJsonDocument document = QJsonDocument::fromJson(reply->readAll());
   qDebug() << reply;
    qDebug() <<"Наш document"<< document;
      QJsonObject root = document.object();
      qDebug() <<"Наш root"<< root;
      QJsonValue itog = root.value("response");
      qDebug() <<"Photos"<< itog;
       QJsonObject smth = itog.toObject();

      QJsonArray array = smth["items"].toArray();
      qDebug() <<"Друзья: "<< array.count();
//   // Перебираем все элементы массива


      for(int i = 0; i < array.count(); i++){

        QJsonObject value = array.at(i).toObject();
//       // Забираем значения свойств domain

        QString domain = value.value("domain").toString();
                qDebug() << domain;

//       // Забираем значения свойств имени
                QString name = value.value("first_name").toString();
                       qDebug() << name;

//       // Забираем значения фамилии
                       QString surname = value.value("last_name").toString();
                               qDebug() << surname;

//       // Забираем ссылку на главную картинку
                               QUrl photo = value.value("photo_100").toString();
                                      qDebug() << photo;

      app_model->addItem(ModelObject (domain, photo, name, surname  ));
       qDebug() << app_model->ModelDomain;
        qDebug() << app_model->ModelPhoto;
       qDebug() << app_model->ModelName;
       qDebug() << app_model->ModelSurname;

   }
}



void Httpcontroller::logIN(QString login, QString password){
    qDebug() << "LOGIN" << login;
    qDebug() << "PASSPOWRD" << password;
    QTextStream out(stdout);
           out.setCodec("CP866"); // устанавливаем CP866-кодировку для консоли

           QTime ct = QTime::currentTime();

           qDebug()<< "The time is " << ct.toString("hh:mm:ss.zzz") ;

    QNetworkRequest request(QUrl("http://laba8.std-1054.ist.mospolytech.ru/api/auth/login")); //отпрвляю запрос на сайт

    QByteArray body = "email=anastash@mail.ru&password=Mal_2629";            //правильные данные

    request.setRawHeader("Content-Type","application/x-www-form-urlencoded");
    request.setRawHeader("Accept","application/json");

    if (login == "anastash@mail.ru" && password == "Mal_2629"){
        QEventLoop loop;                                          //ответ сервера
        nam = new QNetworkAccessManager();
        QObject::connect(nam, SIGNAL(finished(QNetworkReply*)), &loop, SLOT(quit()));
        QNetworkReply *reply = nam->post(request, body);
        loop.exec();
        auto reply_body = reply->readAll();
        qDebug() << "ANSWER" << reply_body;
        QJsonDocument document = QJsonDocument::fromJson(reply_body);
        QJsonObject root = document.object();
        QJsonValue itog = root.value("access_token");
        QString token = itog.toString();
        JWT_token = token;
        qDebug() << "TOKEN: " << JWT_token;
        emit tokenToQml(token);
    }


    JWT_token = ""; //записываем токен
}

void Httpcontroller::getData(QString JWT_token){
    if (JWT_token.length() > 0){
        QNetworkRequest request;
        request.setUrl(QUrl("http://laba8.std-1054.ist.mospolytech.ru/JwtAPI"));

        QNetworkReply * reply;
        QEventLoop evntLoop;
        connect(nam, &QNetworkAccessManager::finished, &evntLoop, &QEventLoop::quit);
        reply = nam->get(request);
        evntLoop.exec();
        QString replyString = reply->readAll();
        qDebug() << "ДАННЫЕ" << replyString;
        dataToQml(replyString);
    }
    else{
        QString replyString = "<h1 >Login incorrect</h1>";

        dataToQml(replyString);
    }
}

void Httpcontroller::time( ){


    QTextStream out(stdout);
       out.setCodec("CP866"); // устанавливаем CP866-кодировку для консоли

       QTime ct = QTime::currentTime();

    //   qDebug()<< "The time is " << ct.toString("hh:mm:ss.zzz") ;


      // newdate = ct.toString("hh:mm:ss.zzz");



      // qDebug()<<"Перемннная"<< newdate;


       QString newdate = ct.toString("hh:mm:ss");
       Just_date = newdate;

       qDebug() << "Date: " << newdate;
      // emit timeToQml(newdate);


}


void Httpcontroller::getPhoto(){
   QUrl myPhoto;

   QEventLoop loop;
   nam = new QNetworkAccessManager();

   QObject::connect(nam, // связываем loop  с нашим менеджером
                    SIGNAL(finished(QNetworkReply*)),
                    &loop,
                    SLOT(quit()));

   QNetworkReply *reply = nam->get(QNetworkRequest(QUrl( "https://api.vk.com/method/users.get?uids=kobra_black&fields=photo_200,status&v=5.130"
                                                       "&access_token="+ acctoken)));

   loop.exec();

   QJsonDocument document = QJsonDocument::fromJson(reply->readAll());
   QJsonObject root = document.object();
   QJsonValue itog = root.value("response");
   QJsonArray array = itog.toArray();

   for(int i = 0; i < array.count(); i++){
       QJsonObject value = array.at(i).toObject();

       QUrl photo = value.value("photo_200").toString();
       emit sendToQml(photo);
   }
}

