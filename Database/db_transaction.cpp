#include "db_transaction.h"
#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>
#include <QDateTime>
Db_Transaction* Db_Transaction::instance = nullptr;
Db_Transaction::Db_Transaction(QObject *parent)
    : QObject{parent}
{
    connect();
}

void Db_Transaction::connect()
{
    if(!db.isValid())
        db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("countdownDB.db");

    if(!db.open()){
        qDebug() << "ERROR : " << db.lastError().text();
    }
    else
    {
        qDebug() << "DB Connection Successfull";
        create();
    }
}

Db_Transaction::~Db_Transaction()
{
    if(db.open())
        db.close();
}

void Db_Transaction::create()
{
    QString year = QDateTime::currentDateTime().addYears(2).toString("yyyy");

    QSqlQuery query;
    if(query.exec("CREATE TABLE 'countdown' (id int primary key, datetime text, screen_mode text)"))
        qDebug() << "Created Table!";

    if(query.exec("INSERT INTO 'countdown' values(1,'"+year+"-06-28 19:00:00','dark')"))
        qDebug() << "Data Added'";
}

 QMap<QString, QString> Db_Transaction::getCountdown()
{
    QMap<QString, QString> result;
    QString queryString = "SELECT * FROM countdown WHERE id = 1";
    QSqlQuery query;
    if (query.exec(queryString)) {
        if (query.next()) {
            result["DATETIME"] = query.value("datetime").toString();
            result["SCREENMODE"] = query.value("screen_mode").toString();
        }
    } else {
        qDebug() << "ERROR: " << query.lastError().text();
    }
    return result;
}

bool Db_Transaction::updateDatetime(QString datetime)
{
    QSqlQuery query;
    QString queryString = "UPDATE countdown SET datetime = :datetime WHERE id = :id";
    query.prepare(queryString);
    query.bindValue(":datetime",datetime);
    query.bindValue(":id",1);
    if (query.exec())
        return true;
    else{
        qDebug() << "ERROR : " + query.lastError().text();
        return false;
    }
}

bool Db_Transaction::updateScreenMode(QString screenMode)
{
    QSqlQuery query;
    QString queryString = "UPDATE countdown SET screen_mode = :screen_mode WHERE id = :id";
    query.prepare(queryString);
    query.bindValue(":screen_mode",screenMode);
    query.bindValue(":id",1);
    if (query.exec())
        return true;
    else{
        qDebug() << "ERROR : " + query.lastError().text();
        return false;
    }
}








