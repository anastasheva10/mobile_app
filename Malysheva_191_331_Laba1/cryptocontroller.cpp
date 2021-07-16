//#include "cryptocontroller.h"
//#include <QString>
//#include "openssl/evp.h"
//#include <QFile>
//#include <QByteArray>
//#include <QIODevice>
//#include <QObject>
//#include <QTemporaryFile>
//#include <openssl/conf.h>
//#include <openssl/err.h>
//#include <openssl/aes.h>
//#include <QBuffer>
//#include <QDebug>

//Encriptioncontroller::Encriptioncontroller(QObject *parent):QObject (parent)
//{
//}

//bool Encriptioncontroller::encriptFile(const QString & mkey, const QString & in_file){
//    EVP_CIPHER_CTX *ctx; // создает контекст шифра
//    /* Создаем и инициализируем контекст */
//    if(!(ctx = EVP_CIPHER_CTX_new())){
//        return false;
//    }

//    if (mkey.length() == 32){
//        key = (unsigned char*) mkey.constData();

//        if(1 != EVP_EncryptInit_ex(ctx, EVP_aes_256_cfb(), NULL, reinterpret_cast<unsigned char *>(mkey.toUtf8().data()), key))
//        {
//            return false;
//        }
//    }
//    else{
//        key2 = "32101230123456789873874547898765";

//        if(1 != EVP_EncryptInit_ex(ctx, EVP_aes_256_cfb(), NULL, reinterpret_cast<unsigned char *>(key2.toUtf8().data()), key))
//        {
//            return false;
//        }
//    }

//    unsigned char ciphertext[256] = {0};
//    unsigned char plaintexttext[256] = {0};
//    int len = 0, plaintext_len = 0;

//    soursefile = in_file.mid(8);
//    QFile sourse_file(soursefile);
//    sourse_file.open(QIODevice::ReadOnly);

//    int position = soursefile.lastIndexOf(".");
//    QString file_extension = soursefile.mid(position);
//    QString soursefile_enc = soursefile.left(position) + "_encryption" + file_extension;

////и создать (открыть с перезаписью) файл с шифрованными данными
//    QFile file_modificate(soursefile_enc);
//    file_modificate.open(QIODevice::ReadWrite | QIODevice::Truncate);
//    plaintext_len = sourse_file.read((char *)plaintexttext, 256);
//    while(plaintext_len > 0){
//        // 1. Считать очередную порцию данных из файла в буфер plaintext
//               //...
//               // 2.Применить функцию EVP_EncryptUpdate для получения ciphertext и len
//        if(1 != EVP_EncryptUpdate(ctx, // уже заполненная структура с настройками
//                                  ciphertext,// выходной параметр, куда записывается шифрованный текст
//                                  &len, // выходной параметр, количество зашифрованных символов, объем в байтах
//                                  plaintexttext, // входной параметр, шифруемый буфер
//                                  plaintext_len)) // входной параметр, количество исходных символов
//        {
//            return false;
//        }

//        //запись ciphertext в файл шифрованных данных
//        file_modificate.write((char *)ciphertext, len);
//        plaintext_len = sourse_file.read((char *)plaintexttext, 256); // считывание каждого блока по 256 символово и запись в файл
//    }

//    if(1 != EVP_EncryptFinal_ex(ctx, ciphertext + len, &len))
//    {
//        return false;
//    }

//    file_modificate.write((char*)ciphertext, len);
//    EVP_CIPHER_CTX_free(ctx);

//    //Закрытие файлов
//    sourse_file.close();
//    file_modificate.close();

//    return true;
//}

//bool Encriptioncontroller::decriptFile(const QString & mkey, const QString & in_file){
//    EVP_CIPHER_CTX *ctx;
//  //  QObject* cryptoArea = EncryptFile->findChild<QObject*>("cryptoArea");

//    if(!(ctx = EVP_CIPHER_CTX_new())){
//        return false;
//    }

//    if (mkey.length() == 32){
//        key = (unsigned char*) mkey.data();

//        if(1 != EVP_DecryptInit_ex(ctx, EVP_aes_256_cfb(), NULL,
//                                   reinterpret_cast<unsigned char *>(mkey.toUtf8().data()), key))// вектор инициализации
//        {
//            return false;
//        }
//    }
//    else{
//  //      key2 = "32101230123456789873874547898765";

//        if(1 != EVP_DecryptInit_ex(ctx, EVP_aes_256_cfb(), NULL, reinterpret_cast<unsigned char *>(key2.toUtf8().data()), key))
//        {
//            return false;
//        }
//    }

//    unsigned char ciphertext[256] = {0};
//    unsigned char plaintexttext[256] = {0};
//    int len = 0, plaintext_len = 0;

//    soursefile = in_file.mid(8);
//    QFile sourse_file(soursefile);
//    sourse_file.open(QIODevice::ReadOnly);

//    int position = soursefile.lastIndexOf(".");
//    QString file_extension = soursefile.mid(position);
//    QString soursefile_dec = soursefile.left(position) + "_decryption" + file_extension;

//    //и создать (открыть с перезаписью) файл с шифрованными данными
//    QFile file_modificate(soursefile_dec);
//    file_modificate.open(QIODevice::ReadWrite | QIODevice::Truncate);
//    plaintext_len = sourse_file.read((char *)plaintexttext, 256);

//    while(plaintext_len > 0){
//        if(1 != EVP_DecryptUpdate(ctx, ciphertext, &len, plaintexttext, plaintext_len))
//        {
//            return false;
//        }

//        //Запись ciphertext в файл шифрованных данных
//        file_modificate.write((char *)ciphertext, len);
//         plaintext_len = sourse_file.read((char *)plaintexttext, 256);



//    }


//    // qDebug() << ciphr;
//   // cryptoArea->setProperty("text", ciphr);
//    //emit sendToQml(ciphr);


//    if(!EVP_DecryptFinal_ex(ctx, ciphertext + len, &len))
//                return false;

//    file_modificate.write((char*)ciphertext, len);
//    EVP_CIPHER_CTX_free(ctx);
//     // закрытие файлов
//    sourse_file.close();
//    file_modificate.close();
//    return true;
//}
