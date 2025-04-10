#ifndef DB_TRANSACTION_H
#define DB_TRANSACTION_H

#include <QObject>
#include <QSqlDatabase>

class Db_Transaction : public QObject
{
    Q_OBJECT
    explicit Db_Transaction(QObject *parent = nullptr);
    static Db_Transaction* instance;
public:
    Db_Transaction(const Db_Transaction& obj) = delete;
    static Db_Transaction* getInstance()
    {
        if (instance == nullptr)
        {
            instance = new Db_Transaction();
            return instance;
        }
        else
        {
            return instance;
        }
    }
    QMap<QString, QString> getCountdown();
    bool updateDatetime(QString datetime);
    bool updateScreenMode(QString screenMode);
private:
    void connect();
    ~Db_Transaction();
    void create();

    QSqlDatabase db;
signals:
};

#endif // DB_TRANSACTION_H
