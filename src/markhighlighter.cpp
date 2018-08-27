#include "markhighlighter.h"

MarkHighlighter::MarkHighlighter(Palette palette, QTextDocument *parent)
    : QSyntaxHighlighter(parent) {
    HighlightingRule rule;

    // Lists
    m_listFormat.setForeground(palette.blue);
    m_listFormat.setFontWeight(QFont::Bold);

    // *, -, +
    rule.pattern = QRegExp("^\\s?[\\*+-]\\s");
    rule.format = m_listFormat;
    m_highlightingRules.append(rule);
    // 1., 2., 3...,
    rule.pattern = QRegExp("^\\s?[0-9].\\s");
    rule.format = m_listFormat;
    m_highlightingRules.append(rule);

    // Headings (# My Title)
    m_atxTitleFormat.setFontWeight(QFont::Bold);
    rule.pattern = QRegExp("^\\s?#[^\n]*");
    rule.format = m_atxTitleFormat;
    m_highlightingRules.append(rule);

    // Italic text
    m_emphasisItalicFormat.setFontItalic(true);
    // *italic*
    rule.pattern = QRegExp("\\*\\S[^\n][^*]*\\S\\*");
    rule.format = m_emphasisItalicFormat;
    m_highlightingRules.append(rule);
    // _italic_
    rule.pattern = QRegExp("_\\S[^\n][^_]*\\S_");
    rule.format = m_emphasisItalicFormat;
    m_highlightingRules.append(rule);

    // Bold text
    m_emphasisBoldFormat.setFontWeight(QFont::Bold);
    // **bold**
    rule.pattern = QRegExp("\\*{2}\\S[^\n\\*]*\\S\\*{2}");
    rule.format = m_emphasisBoldFormat;
    m_highlightingRules.append(rule);
    // __bold__
    rule.pattern = QRegExp("__\\S[^\n_]*\\S__");
    rule.format = m_emphasisBoldFormat;
    m_highlightingRules.append(rule);

    // Strikethrough
    m_emphasisStrikethroughFormat.setFontStrikeOut(true);
    // ~~strikethrough~~
    rule.pattern = QRegExp("~~\\S[^\n~~]*\\S~~");
    rule.format = m_emphasisStrikethroughFormat;
    m_highlightingRules.append(rule);

    // Links
    m_linkFormat.setForeground(palette.purple);
    // [alt](url)
    rule.pattern = QRegExp("\\[[^\n\\[\\]]*\\]\\([^\n\\(\\)]*\\)");
    rule.format = m_linkFormat;
    m_highlightingRules.append(rule);
    // [alt][ref]
    rule.pattern = QRegExp("(\\[[^\n\\[\\]]*\\]){2}");
    rule.format = m_linkFormat;
    m_highlightingRules.append(rule);
    // [ref]:
    rule.pattern = QRegExp("\\[[^\n\\[\\]]*\\]:");
    rule.format = m_linkFormat;
    m_highlightingRules.append(rule);

    // URLs
    m_urlFormat.setForeground(palette.orange);
    m_urlFormat.setFontUnderline(true);
    rule.pattern = QRegExp("https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)");
    rule.format = m_urlFormat;
    m_highlightingRules.append(rule);

    // Images
    m_imagesFormat.setForeground(palette.red);
    rule.pattern = QRegExp("\\!\\[[^\n\\[\\]]*\\]");
    rule.format = m_imagesFormat;
    m_highlightingRules.append(rule);

    // Code
    m_codeFormat.setForeground(palette.blue);
    // Single line code
    rule.pattern = QRegExp("`\\S[^\n`]*\\S`");
    rule.format = m_codeFormat;
    m_highlightingRules.append(rule);
    // Multiline code
    rule.pattern = QRegExp("```");
    rule.format = m_codeFormat;
    m_highlightingRules.append(rule);

    // Quotes
    m_quoteFormat.setForeground(palette.lightGrey);
    m_quoteFormat.setFontItalic(true);
    rule.pattern = QRegExp("^\\s?>[^\n]*");
    rule.format = m_quoteFormat;
    m_highlightingRules.append(rule);

    // Horizontal Rules
    m_horizontalRuleFormat.setFontWeight(QFont::Bold);
    rule.pattern = QRegExp("^\\s?-{3,}");
    rule.format = m_horizontalRuleFormat;
    m_highlightingRules.append(rule);
    rule.pattern = QRegExp("^\\s?\\*{3,}");
    rule.format = m_horizontalRuleFormat;
    m_highlightingRules.append(rule);
    rule.pattern = QRegExp("^\\s?_{3,}");
    rule.format = m_horizontalRuleFormat;
    m_highlightingRules.append(rule);
}

void MarkHighlighter::highlightBlock(const QString &text)
{
    foreach (const HighlightingRule &rule, m_highlightingRules) {
        QRegExp expression(rule.pattern);
        int index = expression.indexIn(text);
        while (index >= 0) {
            int length = expression.matchedLength();
            setFormat(index, length, rule.format);
            index = expression.indexIn(text, index + length);
        }
    }
}
