#include <QProcess>
#include <QVariant>
#include <QString>
#include <QDebug>

class Process : public QProcess {
    Q_OBJECT

public:
    Process(QObject *parent = 0) : QProcess(parent) { }

    Q_INVOKABLE void start(const QString &program, const QVariantList &arguments, const bool &waitUntilFinished) {
        QStringList args;

        // convert QVariantList from QML to QStringList for QProcess 


        for (int i = 0; i < arguments.length(); i++)
            args << arguments[i].toString();
        qWarning() << program << args.join(" ").toStdString().c_str();
        QProcess::setEnvironment(QProcess::systemEnvironment());
        QProcess::setProcessChannelMode(QProcess::MergedChannels);
        QProcess::start(program, args);
        if(waitUntilFinished){
            QProcess::waitForFinished();
        }
    }

    Q_INVOKABLE QByteArray readAll() {
        QByteArray text = QProcess::readAll();
        return text;
    }

    Q_INVOKABLE qint64 writeToStdin(QString data) {
        const char* myChar = data.toStdString().c_str();
        return QProcess::write(myChar);
    } 
    
    Q_INVOKABLE bool waitForStarted() {
        return QProcess::waitForStarted();
    }

    Q_INVOKABLE bool waitForFinished() {
        return QProcess::waitForFinished();
    }
};