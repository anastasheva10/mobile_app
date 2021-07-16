#include "model.h"
#include <QAbstractItemModel>
#include <QMap>


// TODO реализация конструктора и get-методов FriendObject простейшая, проработать самостоятельно

ModelObject::ModelObject(const QString &getuserid, const QUrl &getPhoto, const QString &getName, const QString &getSurname)
    : m_userid(getuserid),
      m_photo(getPhoto),
      m_name(getName),
      m_surname(getSurname)
{
 //
}


Model::Model(QObject *parent) : QAbstractListModel(parent)
{
    //пусто
}

QString ModelObject::getDomain() const{ // функция для получения id друга
    return m_userid;
}

QUrl ModelObject::getPhoto() const{ // функция для получения фото друга
    return m_photo;
}

QString ModelObject::getName() const{ // функция для получения имени друга
    return m_name;
}

QString ModelObject::getSurname() const{ // функция для получения фамилии друга
    return m_surname;
}



void Model::addItem(const ModelObject & newItem){
    // не изменяется
  // благодаря beginInsertRows() и endInsertRows() QML реагирует на изменения модели
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << newItem;
    endInsertRows();
}

int Model::rowCount(const QModelIndex &parent) const
{
    // не изменяется
   // метод используется ListView в QML для определения числа элементов
    Q_UNUSED(parent);
    return m_items.count();
}

QVariant Model::data(const QModelIndex & index,
                                int role) const
{
     // метод используется в QML для получения значения одного поля под обозначением role одного элемента модели index
    if (index.row() < 0 || (index.row() >= m_items.count()))
        return QVariant();

    // TODO дописать выгрузку своих полей под своими обозначениями

    const ModelObject&itemToReturn = m_items[index.row()];
    if (role == ModelDomain)
    return itemToReturn.getDomain();
    else if (role == ModelPhoto)
    return itemToReturn.getPhoto();
    else if (role == ModelName)
    return itemToReturn.getName();
    else if (role == ModelSurname)
    return itemToReturn.getSurname();

    return QVariant();
}

QHash<int, QByteArray> Model::roleNames() const
{
    // метод используется в QML для сопоставления полей данных со строковыми названиями
     // TODO сопоставить полям данных строковые имена
    QHash<int, QByteArray> roles;

    roles[ ModelDomain] = "user_id";
    roles[ ModelPhoto] = "pict";
    roles[ ModelName] = "name";
    roles[ ModelSurname] = "surname";
    return roles;
}

QVariantMap Model::get(int idx) const
{
    // не изменяется
   // метод используется ListView в QML для получения значений полей idx-го элемента модели
    QVariantMap map;
    foreach(int k, roleNames().keys())
    {
        map[roleNames().value(k)] = data(index(idx, 0), k);
    }
    return map;
}

void Model::clear()
{
    beginRemoveRows(QModelIndex(), 0, rowCount()-1);
    m_items.clear();
    endRemoveRows();
}
