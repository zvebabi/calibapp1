#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <QIcon>

#include "uartReader.h"
#include "mydevice.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QLocale::setDefault(QLocale(QLocale::English, QLocale::UnitedStates));
    QApplication app(argc, argv);
    qApp->setQuitOnLastWindowClosed(true);
    QQuickStyle::setStyle("Material");
    qmlRegisterType<MyDevice>("mydevice", 1, 0, "MyDevice");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject* root = engine.rootObjects()[0];
    app.setWindowIcon(QIcon(":/images/logo_icon_7.png"));
    uartReader *reader= new uartReader(root);

    engine.rootContext()->setContextProperty("reciever", reader);

    return app.exec();
}
