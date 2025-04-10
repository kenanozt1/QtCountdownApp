#include "countdowncontroller.h"
#include "Database/db_transaction.h"
#include <QDebug>

CountdownController* CountdownController::instance = nullptr;
CountdownController::CountdownController(QObject *parent)
    : QObject{parent}
{
    getvalueDB();
}

void CountdownController::getvalueDB()
{
    auto countdown = Db_Transaction::getInstance()->getCountdown();
    datetime = countdown["DATETIME"];
    screenMode = countdown["SCREENMODE"];
}

void CountdownController::updateDatetime()
{
    if(Db_Transaction::getInstance()->updateDatetime(datetime))
        qDebug() << "Update to Datetime";
    else
        qDebug() << "Error! Not Update Datetime";
}

void CountdownController::updateScreenMode()
{
    if(Db_Transaction::getInstance()->updateScreenMode(screenMode))
        qDebug() << "Update to Screen Mode";
    else
        qDebug() << "Error! Not Update Screen Mode";
}

QString CountdownController::getDatetime() const
{
    return datetime;
}

void CountdownController::setDatetime(const QString &newDatetime)
{
    datetime = newDatetime;
    updateDatetime();
}

QString CountdownController::getScreenMode() const
{
    return screenMode;
}

void CountdownController::setScreenMode(const QString &newScreenMode)
{
    screenMode = newScreenMode;
    updateScreenMode();
}
