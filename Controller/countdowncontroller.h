#ifndef COUNTDOWNCONTROLLER_H
#define COUNTDOWNCONTROLLER_H

#include <QObject>

class CountdownController : public QObject
{
    Q_OBJECT

    explicit CountdownController(QObject *parent = nullptr);
    static CountdownController* instance;
public:
    CountdownController(const CountdownController& obj) = delete;
    static CountdownController* getInstance()
    {
        if (instance == nullptr)
        {
            instance = new CountdownController();
            return instance;
        }
        else
        {
            return instance;
        }
    }
    Q_INVOKABLE void getvalueDB();

    Q_INVOKABLE void updateDatetime();
    Q_INVOKABLE void updateScreenMode();

    Q_INVOKABLE QString getDatetime() const;
    Q_INVOKABLE void setDatetime(const QString &newDatetime);

    Q_INVOKABLE QString getScreenMode() const;
    Q_INVOKABLE void setScreenMode(const QString &newScreenMode);

private:
    QString datetime;
    QString screenMode;
signals:
};

#endif // COUNTDOWNCONTROLLER_H
