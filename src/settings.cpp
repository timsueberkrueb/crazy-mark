#include "settings.h"

Settings::Settings(QString path, QObject *parent)
{
    Q_UNUSED(parent);
    m_path = path;

    if (!QDir(m_path).exists())
        QDir().mkdir(m_path);

    QFileInfo checkFile(m_path + m_fileName);
    if (!checkFile.exists() || !checkFile.isFile()) {
        qDebug() << "Settings file does not exist. Creating default file at " << m_path + m_fileName;
        QFile file( m_path + m_fileName );
        if ( file.open(QIODevice::WriteOnly) )
        {
            QTextStream stream( &file );
            stream << getDefaultJson() << endl;
        }
    }
}

bool Settings::save()
{   
    QFile file( m_path + m_fileName );
    if ( !file.open(QIODevice::WriteOnly) ) {
        qWarning("Could not open settings file.");
        return false;
    }
    QTextStream stream( &file );
    stream << getJson() << endl;
    return true;
}

bool Settings::load()
{
    QFile file(m_path + m_fileName);

    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("Could not open settings file.");
        return false;
    }

    QByteArray jsonByteData = file.readAll();
    QJsonDocument doc (QJsonDocument::fromJson(jsonByteData));

    auto json = doc.object();
    QJsonObject jsonData = json["data"].toObject();

    switch(jsonData["contentexchangemode"].toInt()) {
        case 0:
            setContentExchangeMode(ContentExchangeMode::ContentHub);
            break;
        case 1:
            setContentExchangeMode(ContentExchangeMode::Desktop);
            break;
    }
    setAutoCompletion(jsonData["autocompletion"].toBool());
    setToolbarExpanded(jsonData["expandedtoolbar"].toBool());
    setOpenPreview(jsonData["openpreview"].toBool());
    setDefaultBulletCharacter(jsonData["defaultbulletcharacter"].toString());

    return true;
}

QString Settings::getDefaultJson()
{
    QJsonObject data {
        {"autocompletion", true},
        {"defaultbulletcharacter", "-"},
        {"openpreview", false},
        {"expandedtoolbar", false},
        {"contentexchangemode", 0}
    };
    QJsonObject meta {
        {"schema", "0.1"}
    };
    QJsonObject json {
        {"meta", meta},
        {"data", data}
    };
    QJsonDocument doc(json);
    return doc.toJson();
}

QString Settings::getJson()
{
    int contentExchangeNum = 0;
    switch(m_contentExchangeMode) {
        case ContentExchangeMode::ContentHub:
            contentExchangeNum = 0;
            break;
        case ContentExchangeMode::Desktop:
            contentExchangeNum = 1;
            break;
    }

    QJsonObject data {
        {"autocompletion", m_autoCompletion},
        {"defaultbulletcharacter", m_defaultBulletCharacter},
        {"openpreview", m_openPreview},
        {"expandedtoolbar", m_toolbarExpanded},
        {"contentexchangemode", contentExchangeNum}
    };
    QJsonObject meta {
        {"schema", "0.1"}
    };
    QJsonObject json {
        {"meta", meta},
        {"data", data}
    };
    QJsonDocument doc(json);
    return doc.toJson();
}
