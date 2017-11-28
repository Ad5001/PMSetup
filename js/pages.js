// Checks for the pages
.pragma library
var pages;
var selectedPage;

function init(pagesArg, selPage) {
    pages = pagesArg;
    selectedPage = selPage;
}

function switchPage(pageId) {
    selectedPage.visible = false;
    selectedPage.z = -1;
    selectedPage = pages[pageId];
    selectedPage.visible = true;
    selectedPage.z = 1;
}