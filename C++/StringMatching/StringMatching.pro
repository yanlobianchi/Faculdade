QT += core
QT -= gui
TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
DEFINES += QT_DEPRECATED_WARNINGS
SOURCES += main.cpp

HEADERS += \
    trie.h
