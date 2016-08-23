#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QByteArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDir>
#include <QFileInfo>
#include <QDebug>

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(ContentExchangeMode contentExchangeMode READ getContentExchangeMode WRITE setContentExchangeMode NOTIFY contentExchangeModeChanged)
    Q_PROPERTY(bool autoCompletion READ getAutoCompletion WRITE setAutoCompletion NOTIFY autoCompletionChanged)
    Q_PROPERTY(bool toolbarExpanded READ getToolbarExpanded WRITE setToolbarExpanded NOTIFY toolbarExpandedChanged)
    Q_PROPERTY(bool openPreview READ getOpenPreview WRITE setOpenPreview NOTIFY openPreviewChanged)
    Q_PROPERTY(QString defaultBulletCharacter READ getDefaultBulletCharacter WRITE setDefaultBulletCharacter NOTIFY defaultBulletCharacterChanged)
    Q_ENUMS(ContentExchangeMode)
public:
    Settings() = default;
    explicit Settings(QString path, QObject *parent = 0);

    Q_INVOKABLE bool save();
    Q_INVOKABLE bool load();

    QString getDefaultJson();
    QString getJson();

    enum ContentExchangeMode {
        ContentHub = 0,
        Desktop
    };

    ContentExchangeMode getContentExchangeMode() const { return m_contentExchangeMode; }
    void setContentExchangeMode(ContentExchangeMode contentExchangeMode) { m_contentExchangeMode = contentExchangeMode; contentExchangeModeChanged(contentExchangeMode); }

    bool getAutoCompletion() const { return m_autoCompletion; }
    void setAutoCompletion(bool autoCompletion) { m_autoCompletion = autoCompletion; autoCompletionChanged(autoCompletion); }

    bool getToolbarExpanded() const { return m_toolbarExpanded; }
    void setToolbarExpanded(bool toolbarExpanded) { m_toolbarExpanded = toolbarExpanded; toolbarExpandedChanged(toolbarExpanded); }

    bool getOpenPreview() const { return m_openPreview; }
    void setOpenPreview(bool openPreview) { m_openPreview = openPreview; openPreviewChanged(openPreview); }

    QString getDefaultBulletCharacter() const { return m_defaultBulletCharacter; }
    void setDefaultBulletCharacter(QString bc) { m_defaultBulletCharacter = bc; defaultBulletCharacterChanged(bc); }

private:
    ContentExchangeMode m_contentExchangeMode;
    bool m_autoCompletion;
    bool m_toolbarExpanded;
    bool m_openPreview;
    QString m_defaultBulletCharacter;

    QString m_path;
    QString m_fileName = "settings.json";

signals:
    void contentExchangeModeChanged(ContentExchangeMode contentExchangeMode);
    void autoCompletionChanged(bool autoCompletion);
    void toolbarExpandedChanged(bool toolbarExpanded);
    void openPreviewChanged(bool openPreview);
    void defaultBulletCharacterChanged(QString defaultBulletCharacterChanged);

public slots:
};

#endif // SETTINGS_H
