#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.addImportPath(TaoQuickImportPath);
    engine.rootContext()->setContextProperty("taoQuickImportPath", TaoQuickImportPath);

    const QUrl url = QStringLiteral("qrc:/qt/qml/fat-client/main.qml");
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);

    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/fat-client/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
