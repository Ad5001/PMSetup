// Checks for the pages
.pragma library
var pages;
var selectedPage;
var header;

function init(pagesArg, selPage, head) {
    pages = pagesArg;
    selectedPage = selPage;
    header = head;
}

function switchPage(pageId) {
    // Hide the last page
    selectedPage.exit();
    // Show the new page
    selectedPage = pages[pageId];
    selectedPage.enter();
    // Show the header
    header.visible = true;
    header.text.text = "Step " + selectedPage.stepId + ". " + selectedPage.stepName
    header.icon.source = "file://" + selectedPage.stepIcon
    header.progressbar.updateBar(selectedPage.stepId)
}