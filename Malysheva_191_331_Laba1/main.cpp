
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QNetworkReply>
#include <QtWebView>
#include "Httpcontroller.h"
//#include <QtWebEngine>
#include "model.h"
//#include "cryptocontroller.h"

//#if defined(ANDROID)
//    #include <QAndroidJniObject>
//    #include <QAndroidJniEnvironment>
//    #include <QtAndroid>
//#endif  // defined(ANDROID)

//#include "firebase/analytics.h"
//#include "firebase/analytics/event_names.h"
//#include "firebase/analytics/parameter_names.h"
//#include "firebase/analytics/user_property_names.h"
//#include <firebase/app.h>

//namespace analytics = ::firebase::analytics;

int main(int argc, char *argv[])
{
   //Вызов независимой функции
   //в составе класса QCoreApplication (без создания экземпляров класса)
   //просто настройка масштабирования экрана.
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //Создается базовое приложение с графической областью
QGuiApplication app(argc, argv);
//QtWebEngine::initialize();


        QCoreApplication::setOrganizationName(QStringLiteral("MobDev"));

      QCoreApplication::setOrganizationDomain(QStringLiteral("qt"));

        Httpcontroller httpController;
     //Создание браузерного движка
    QQmlApplicationEngine engine;
     //Encriptioncontroller crypt;

     QQmlContext *context = engine.rootContext();
       context->setContextProperty("app_model", httpController.app_model); //Перемещаемая модель, которой присваиваем имя
    context->setContextProperty("httpController", &httpController);
       //преобразование пути стартовой страницы из char в Qurl

       //подлючение слота, срабатывающего после создания objectCreated
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;




    QObject::connect(engine.rootObjects().first(), SIGNAL(restRequest()),
    &httpController, SLOT(restRequest()));

    QObject::connect(engine.rootObjects().first(), SIGNAL(failed(QString)),
    &httpController, SLOT(failed(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(hashvd(QString)),
    &httpController, SLOT(hashvd(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(cancel(QString)),
    &httpController, SLOT(cancel(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(success(QString)),
    &httpController, SLOT(success(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(getPhoto()),
    &httpController, SLOT(getPhoto()));



    QObject* main = engine.rootObjects()[0];
     Httpcontroller sendtoqml(main);
    engine.rootContext()->setContextProperty("_send", &sendtoqml);
    //context -> setContextProperty("crypt", &crypt);


//    firebase::App * fb_app = nullptr;          //инициализация firebase

//        #if defined(ANDROID)
//            QAndroidJniEnvironment qjniEnv;
//            QAndroidJniObject qactivity = QtAndroid::androidActivity();
//            fb_app = firebase::App::Create(firebase::AppOptions(), qjniEnv, qactivity.object());
//        #else
//            fb_app = firebase::App::Create(firebase::AppOptions());
//        #endif  // defined(ANDROID)

//        // инициализация подсистемы аналитики
//        firebase::analytics::Initialize(*fb_app);
//        firebase::analytics::SetAnalyticsCollectionEnabled(true);

//        //TODO отправить сообещение в БД
//        //TODO просмотреть сообщение

//        //analytics::LogEvent(analytics::kEventLogin);



//        auto result = app.exec();

//        firebase::analytics::Terminate();
//        delete fb_app;
//        return result;


    return app.exec();//запуск бесконечного цикла обработки сообщений и слотов/сигналов
}



