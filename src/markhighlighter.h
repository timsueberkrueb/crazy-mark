#ifndef MARKHIGHLIGHTER_H
#define MARKHIGHLIGHTER_H

#include <QSyntaxHighlighter>
#include "palette.h"

class MarkHighlighter : public QSyntaxHighlighter
{
public:
    MarkHighlighter(Palette palette, QTextDocument *parent = 0);

protected:
    void highlightBlock(const QString &text) Q_DECL_OVERRIDE;
private:
    struct HighlightingRule
    {
        QRegExp pattern;
        QTextCharFormat format;
    };
    QVector<HighlightingRule> m_highlightingRules;

    /* md specific */
    QTextCharFormat m_atxTitleFormat;                 // Headers (# My Title)
    QTextCharFormat m_emphasisItalicFormat;           // Italic text (*italic* or _italic_)
    QTextCharFormat m_emphasisBoldFormat;             // Bold text (**bold** or __bold__)
    QTextCharFormat m_emphasisStrikethroughFormat;    // Strikethrough (~~text~~)
    QTextCharFormat m_listFormat;                     // Lists (1., 2., 3..., *, -, +)
    QTextCharFormat m_linkFormat;                     // Links [alt](https://www.example.com)
    QTextCharFormat m_urlFormat;                      // Urls (http://example.com)
    QTextCharFormat m_imagesFormat;                   // Images ![alt text][src]
    QTextCharFormat m_codeFormat;                     // Code `inline` ``` multiline ```
    QTextCharFormat m_quoteFormat;                    // Quotes > my quote
    QTextCharFormat m_horizontalRuleFormat;           // Horizontal lines (--- *** ___)
};

#endif // MARKHIGHLIGHTER_H
