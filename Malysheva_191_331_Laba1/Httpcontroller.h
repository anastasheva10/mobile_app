#ifndef HTTPCONTROLLER_H
#define HTTPCONTROLLER_H


#include <QObject>
#include <QNetworkAccessManager>


class Httpcontroller : public QObject
{
    Q_OBJECT
public:
    explicit Httpcontroller  (QObject *parent = nullptr);
     QNetworkAccessManager *nam;

signals:
public slots:
    void onNetworkValue(QNetworkReply *reply);
    void getNetworkValue();
         bool failed (QString add);
         bool cancel (QString add);
protected:
    QObject *pocaz;

};


#endif // HTTPCONTROLLER_H
