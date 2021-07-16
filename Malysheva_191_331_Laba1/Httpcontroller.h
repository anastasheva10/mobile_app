#ifndef HTTPCONTROLLER_H
#define HTTPCONTROLLER_H


#include <QObject>
#include <QNetworkAccessManager>
#include <QCryptographicHash>
#include <model.h>


class Httpcontroller : public QObject

{
    Q_OBJECT
public:
    explicit Httpcontroller(QObject *parent = nullptr);

    QNetworkAccessManager *nam;
    QString acctoken; // полученный access_token
        Model *app_model; // наша модель
        QString secret; //получение секрета, записываем token
        QString hash; // получение хеша
        QString JWT_token;//получение JWT токена
        QString Just_date;

signals:
    //    void signalSendToQML(QString pReply);

        void tokenToQml(QString token);
        void dataToQml(QString pageContent);
        void timeToQml(QString newdate);
        void sendToQml(QUrl url);

public slots:
    void onNetworkValue(QNetworkReply *reply);
    void getNetworkValue();
    //  void SlotFinished(QNetworkReply *reply);
    QString success (QString add);
         bool failed (QString add);
         bool cancel (QString add);
         void restRequest();
         void hashvd(QString add);
         void logIN(QString login, QString password);
         void getData(QString JWT_token);
         void time();
         void getPhoto();


protected:
    QObject *pocaz;

};

#endif // QHTTPCONTROLLER_H
