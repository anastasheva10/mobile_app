#ifndef MODEL_H
#define MODEL_H
#include <QObject>
#include <QAbstractItemModel>
#include<QAbstractListModel>
#include <QList>
#include <QModelIndex>
#include <QVariant>
#include <QUrl>
#include <QVariant>

class ModelObject
{
public:
    ModelObject(const QString &domain,
                    const  QUrl &photo,
                    const QString &name,
                    const QString &surname);
        //
        QString getDomain() const;
        QUrl getPhoto() const;
        QString getName() const;
        QString getSurname() const;
        // прочие get-методы для выдачи ID, URL фотографии и др.

private:
    QString m_userid;
    QUrl  m_photo;
    QString m_name;
    QString m_surname;
    // прочие свойства для хранения ID, URL фотографии и др.
};

class Model : public QAbstractListModel
{
    Q_OBJECT
public:
    enum enmRoles {
        ModelDomain,
         ModelPhoto,
        ModelName = Qt::UserRole + 1,
         ModelSurname
    };
    Model(QObject *parent = nullptr);

    void addItem(const ModelObject & newItem);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const; // возвращает по индексу переменную (используется в ЛР 8)

    QVariantMap get(int idx) const;

    void clear();

 protected:
    QHash<int, QByteArray> roleNames() const;
    // ключ - значение
    // нужен, чтобы строковые имена приводить в соответствие к полям френда

 private:

   QList<ModelObject> m_items;

};

#endif // MODEL_H

