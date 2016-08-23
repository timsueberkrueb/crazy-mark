var textArea;
var localizedDefaultWord = i18n.tr("word");

function markText(start, end, mark, defaultWord) {
    if (!defaultWord)
        defaultWord = localizedDefaultWord;
    if (start === end) {
        textArea.insert(start, defaultWord);
        end = start + defaultWord.length;
    }
    textArea.insert(start, mark);
    textArea.insert(end + mark.length, mark)
}

function markSelected(mark, defaultWord, setFocus) {
    if (!defaultWord)
        defaultWord = localizedDefaultWord;
    var start = textArea.selectionStart;
    var end = textArea.selectionEnd;
    markText(start, end, mark, defaultWord);
    if (start === end)
        textArea.select(start + mark.length, start + mark.length + defaultWord.length);
    else
        textArea.select(start + mark.length, end + mark.length);
    if (setFocus !== false)
        textArea.focus = true;
}
