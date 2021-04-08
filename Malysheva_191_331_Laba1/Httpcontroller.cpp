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
#include "Httpcontroller.h"


Httpcontroller::Httpcontroller(QObject *QMLObject) : pocaz(QMLObject)
{
    nam = new QNetworkAccessManager(this); // создаем менеджер
        //  connect(nam, &QNetworkAccessManager::finished, this, &HttpController::SlotFinished);
        connect(nam, &QNetworkAccessManager::finished, this, &Httpcontroller::onNetworkValue);

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
         textField->setProperty("text", str.mid( j + 162,2)); // мы находим 140 символ после тега и отсчитываем 2 символов и их выводим (курс доллара) и записываем в textField
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
