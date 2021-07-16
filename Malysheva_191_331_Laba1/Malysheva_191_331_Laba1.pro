QT += quick multimedia multimediawidgets


CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        Httpcontroller.cpp \
    cryptocontroller.cpp \
    main.cpp \
    model.cpp


RESOURCES += qml.qrc



INCLUDEPATH += \
       D:\QT\Tools\OpenSSL\Win_x64\include\openssl # загаловочные файлы
LIBS += \
        D:\QT\Tools\OpenSSL\Win_x64\lib\libcrypto.lib # библиотека, содержащая таблицу соответствий названий функций и их адресов
INCLUDEPATH += D:/QT/Tools/OpenSSL/Win_x64/include
LIBS += -L"D:/QT/Tools/OpenSSL"


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =


win32:RC_FILE = file.rc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target



HEADERS += \
    Httpcontroller.h \
    cryptocontroller.h \
    model.h
    QMAKE_EXTRA_TARGETS += before_build makefilehook


#android: include(D:/anastasia/android_openssl/openssl.pri)


#INCLUDEPATH += D:/firebase_cpp_sdk/include



#android {
#    QT += androidextras
#    LIBS += \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_admob.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_analytics.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_app.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_auth.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_database.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_dynamic_links.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_firestore.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_functions.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_installations.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_instance_id.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_messaging.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_remote_config.a \
#        D:/firebase_cpp_sdk/libs/android/arm64-v8a/c++/libfirebase_storage.a
#}

#win32 {
#    LIBS += \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_admob.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_analytics.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_app.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_auth.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_database.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_dynamic_links.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_firestore.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_functions.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_installations.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_instance_id.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_messaging.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_remote_config.lib \
#        D:/firebase_cpp_sdk/libs/windows/VS2019/MD/x64/Debug/firebase_storage.lib
#}



DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android



greaterThan(QT_MAJOR_VERSION, 4) {
QT += webview     #класс, позволяющие встраивать web-страницы вandroid-приложение
#QT += webengine    #предоставляет функциональность для рендеринга областей динамического веб-контента

}





