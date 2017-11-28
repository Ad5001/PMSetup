#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QObject>
#include <QDebug>
#include <QtQml>
#include "process.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<Process>("Process", 1, 0, "Process");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;



    return app.exec();
}
