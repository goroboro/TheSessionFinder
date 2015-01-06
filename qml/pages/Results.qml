import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Sailfish.Silica 1.0

//currently the search returns pages of 10 results per page... we only display the first 10 results...
//we need to write code to handle multiple pages of results

Page {
    property string queryString
    XmlListModel {
        id: results
        source: "http://thesession.org/tunes/search?type=&mode=&format=xml&q=" + queryString
        query: "/document/tunes/tune"
        XmlRole {
            name: "name"
            query: "name/string()"
        }
        XmlRole {
            name: "url"
            query: "url/string()"
        }
        XmlRole {
            name: "type"
            query: "type/string()"
        }
    }
    id: page

    SilicaListView {
        id: listView
        width: page.width
        height: page.height
        anchors.top: parent.top
        model: results
        header: PageHeader {
            title: "Search Results"
        }
        ViewPlaceholder {
            enabled: results.progress < 1
            text: qsTr("Searching for results...")
        }
        ViewPlaceholder {
            enabled: results.count < 1 && results.progress == 1
            text: qsTr("No results found...")
        }
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Return To Collection"
                onClicked: {
                    pageStack.clear()
                    pageStack.push('CollectionPage.qml')
                }
            }
        }
        VerticalScrollDecorator {
        }
        delegate: Item {
            id: myListItem
            width: ListView.view.width
            height: contentItem.height
            BackgroundItem {
                id: contentItem
                width: parent.width
                property string infoUrl: url + "?format=xml"
                onClicked: pageStack.push(Qt.resolvedUrl("TuneInfo.qml"), {
                                              infoUrl: infoUrl,
                                              tune: name,
                                              type: type
                                          })
            }
            Label {
                x: Theme.paddingLarge
                text: name + ' (' + type + ')'
                anchors.verticalCenter: parent.verticalCenter
                color: contentItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
        }
    }
}
