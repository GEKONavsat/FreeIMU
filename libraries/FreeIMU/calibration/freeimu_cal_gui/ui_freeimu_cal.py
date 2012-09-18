# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'freeimu_cal.ui'
#
# Created: Mon Sep 17 17:59:41 2012
#      by: PyQt4 UI code generator 4.9.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    _fromUtf8 = lambda s: s

class Ui_FreeIMUCal(object):
    def setupUi(self, FreeIMUCal):
        FreeIMUCal.setObjectName(_fromUtf8("FreeIMUCal"))
        FreeIMUCal.resize(800, 600)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Minimum)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(FreeIMUCal.sizePolicy().hasHeightForWidth())
        FreeIMUCal.setSizePolicy(sizePolicy)
        FreeIMUCal.setMinimumSize(QtCore.QSize(800, 600))
        self.centralwidget = QtGui.QWidget(FreeIMUCal)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Maximum, QtGui.QSizePolicy.Maximum)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.centralwidget.sizePolicy().hasHeightForWidth())
        self.centralwidget.setSizePolicy(sizePolicy)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.line = QtGui.QFrame(self.centralwidget)
        self.line.setGeometry(QtCore.QRect(10, 20, 791, 16))
        self.line.setFrameShape(QtGui.QFrame.HLine)
        self.line.setFrameShadow(QtGui.QFrame.Sunken)
        self.line.setObjectName(_fromUtf8("line"))
        self.gridLayoutWidget = QtGui.QWidget(self.centralwidget)
        self.gridLayoutWidget.setGeometry(QtCore.QRect(0, 0, 801, 25))
        self.gridLayoutWidget.setObjectName(_fromUtf8("gridLayoutWidget"))
        self.gridLayout = QtGui.QGridLayout(self.gridLayoutWidget)
        self.gridLayout.setSizeConstraint(QtGui.QLayout.SetNoConstraint)
        self.gridLayout.setMargin(0)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.label = QtGui.QLabel(self.gridLayoutWidget)
        self.label.setObjectName(_fromUtf8("label"))
        self.gridLayout.addWidget(self.label, 0, 0, 1, 1)
        spacerItem = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.gridLayout.addItem(spacerItem, 0, 5, 1, 1)
        self.serialPortEdit = QtGui.QLineEdit(self.gridLayoutWidget)
        self.serialPortEdit.setObjectName(_fromUtf8("serialPortEdit"))
        self.gridLayout.addWidget(self.serialPortEdit, 0, 1, 1, 1)
        self.connectButton = QtGui.QPushButton(self.gridLayoutWidget)
        self.connectButton.setObjectName(_fromUtf8("connectButton"))
        self.gridLayout.addWidget(self.connectButton, 0, 2, 1, 1)
        self.line_2 = QtGui.QFrame(self.gridLayoutWidget)
        self.line_2.setFrameShape(QtGui.QFrame.VLine)
        self.line_2.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_2.setObjectName(_fromUtf8("line_2"))
        self.gridLayout.addWidget(self.line_2, 0, 3, 1, 1)
        self.samplingToggleButton = QtGui.QPushButton(self.gridLayoutWidget)
        self.samplingToggleButton.setEnabled(False)
        self.samplingToggleButton.setAutoDefault(False)
        self.samplingToggleButton.setDefault(False)
        self.samplingToggleButton.setFlat(False)
        self.samplingToggleButton.setObjectName(_fromUtf8("samplingToggleButton"))
        self.gridLayout.addWidget(self.samplingToggleButton, 0, 6, 1, 1)
        self.pushButton = QtGui.QPushButton(self.gridLayoutWidget)
        self.pushButton.setEnabled(False)
        self.pushButton.setObjectName(_fromUtf8("pushButton"))
        self.gridLayout.addWidget(self.pushButton, 0, 7, 1, 1)
        self.gridLayoutWidget_2 = QtGui.QWidget(self.centralwidget)
        self.gridLayoutWidget_2.setGeometry(QtCore.QRect(0, 30, 801, 221))
        self.gridLayoutWidget_2.setObjectName(_fromUtf8("gridLayoutWidget_2"))
        self.gridLayout_2 = QtGui.QGridLayout(self.gridLayoutWidget_2)
        self.gridLayout_2.setMargin(0)
        self.gridLayout_2.setObjectName(_fromUtf8("gridLayout_2"))
        self.acc3D = PlotWidget(self.gridLayoutWidget_2)
        self.acc3D.setObjectName(_fromUtf8("acc3D"))
        self.gridLayout_2.addWidget(self.acc3D, 0, 0, 1, 1)
        self.magn3D = PlotWidget(self.gridLayoutWidget_2)
        self.magn3D.setObjectName(_fromUtf8("magn3D"))
        self.gridLayout_2.addWidget(self.magn3D, 0, 1, 1, 1)
        self.gridLayoutWidget_3 = QtGui.QWidget(self.centralwidget)
        self.gridLayoutWidget_3.setGeometry(QtCore.QRect(0, 260, 801, 301))
        self.gridLayoutWidget_3.setObjectName(_fromUtf8("gridLayoutWidget_3"))
        self.gridLayout_3 = QtGui.QGridLayout(self.gridLayoutWidget_3)
        self.gridLayout_3.setMargin(0)
        self.gridLayout_3.setObjectName(_fromUtf8("gridLayout_3"))
        self.accYZ = PlotWidget(self.gridLayoutWidget_3)
        self.accYZ.setObjectName(_fromUtf8("accYZ"))
        self.gridLayout_3.addWidget(self.accYZ, 1, 0, 1, 1)
        self.accZX = PlotWidget(self.gridLayoutWidget_3)
        self.accZX.setObjectName(_fromUtf8("accZX"))
        self.gridLayout_3.addWidget(self.accZX, 1, 1, 1, 1)
        self.magnYZ = PlotWidget(self.gridLayoutWidget_3)
        self.magnYZ.setObjectName(_fromUtf8("magnYZ"))
        self.gridLayout_3.addWidget(self.magnYZ, 1, 2, 1, 1)
        self.accXY = PlotWidget(self.gridLayoutWidget_3)
        self.accXY.setObjectName(_fromUtf8("accXY"))
        self.gridLayout_3.addWidget(self.accXY, 0, 0, 1, 1)
        self.magnXY = PlotWidget(self.gridLayoutWidget_3)
        self.magnXY.setObjectName(_fromUtf8("magnXY"))
        self.gridLayout_3.addWidget(self.magnXY, 0, 2, 1, 1)
        self.magnZX = PlotWidget(self.gridLayoutWidget_3)
        self.magnZX.setObjectName(_fromUtf8("magnZX"))
        self.gridLayout_3.addWidget(self.magnZX, 1, 3, 1, 1)
        self.formLayout = QtGui.QFormLayout()
        self.formLayout.setSizeConstraint(QtGui.QLayout.SetNoConstraint)
        self.formLayout.setFieldGrowthPolicy(QtGui.QFormLayout.ExpandingFieldsGrow)
        self.formLayout.setObjectName(_fromUtf8("formLayout"))
        self.label_2 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_2.setObjectName(_fromUtf8("label_2"))
        self.formLayout.setWidget(0, QtGui.QFormLayout.LabelRole, self.label_2)
        self.lineEdit = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit.setObjectName(_fromUtf8("lineEdit"))
        self.formLayout.setWidget(0, QtGui.QFormLayout.FieldRole, self.lineEdit)
        self.label_4 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_4.setObjectName(_fromUtf8("label_4"))
        self.formLayout.setWidget(1, QtGui.QFormLayout.LabelRole, self.label_4)
        self.label_3 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_3.setObjectName(_fromUtf8("label_3"))
        self.formLayout.setWidget(2, QtGui.QFormLayout.LabelRole, self.label_3)
        self.lineEdit_2 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.lineEdit_2.sizePolicy().hasHeightForWidth())
        self.lineEdit_2.setSizePolicy(sizePolicy)
        self.lineEdit_2.setObjectName(_fromUtf8("lineEdit_2"))
        self.formLayout.setWidget(1, QtGui.QFormLayout.FieldRole, self.lineEdit_2)
        self.lineEdit_4 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit_4.setObjectName(_fromUtf8("lineEdit_4"))
        self.formLayout.setWidget(3, QtGui.QFormLayout.FieldRole, self.lineEdit_4)
        self.lineEdit_5 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit_5.setObjectName(_fromUtf8("lineEdit_5"))
        self.formLayout.setWidget(4, QtGui.QFormLayout.FieldRole, self.lineEdit_5)
        self.lineEdit_3 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit_3.setObjectName(_fromUtf8("lineEdit_3"))
        self.formLayout.setWidget(5, QtGui.QFormLayout.FieldRole, self.lineEdit_3)
        self.lineEdit_6 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit_6.setObjectName(_fromUtf8("lineEdit_6"))
        self.formLayout.setWidget(2, QtGui.QFormLayout.FieldRole, self.lineEdit_6)
        self.label_5 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_5.setObjectName(_fromUtf8("label_5"))
        self.formLayout.setWidget(3, QtGui.QFormLayout.LabelRole, self.label_5)
        self.label_6 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_6.setObjectName(_fromUtf8("label_6"))
        self.formLayout.setWidget(4, QtGui.QFormLayout.LabelRole, self.label_6)
        self.label_7 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_7.setObjectName(_fromUtf8("label_7"))
        self.formLayout.setWidget(5, QtGui.QFormLayout.LabelRole, self.label_7)
        self.gridLayout_3.addLayout(self.formLayout, 0, 1, 1, 1)
        self.formLayout_2 = QtGui.QFormLayout()
        self.formLayout_2.setSizeConstraint(QtGui.QLayout.SetNoConstraint)
        self.formLayout_2.setFieldGrowthPolicy(QtGui.QFormLayout.ExpandingFieldsGrow)
        self.formLayout_2.setObjectName(_fromUtf8("formLayout_2"))
        self.label_8 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_8.setObjectName(_fromUtf8("label_8"))
        self.formLayout_2.setWidget(0, QtGui.QFormLayout.LabelRole, self.label_8)
        self.lineEdit_7 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit_7.setObjectName(_fromUtf8("lineEdit_7"))
        self.formLayout_2.setWidget(0, QtGui.QFormLayout.FieldRole, self.lineEdit_7)
        self.label_9 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_9.setObjectName(_fromUtf8("label_9"))
        self.formLayout_2.setWidget(1, QtGui.QFormLayout.LabelRole, self.label_9)
        self.label_10 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_10.setObjectName(_fromUtf8("label_10"))
        self.formLayout_2.setWidget(2, QtGui.QFormLayout.LabelRole, self.label_10)
        self.lineEdit_8 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.lineEdit_8.sizePolicy().hasHeightForWidth())
        self.lineEdit_8.setSizePolicy(sizePolicy)
        self.lineEdit_8.setObjectName(_fromUtf8("lineEdit_8"))
        self.formLayout_2.setWidget(1, QtGui.QFormLayout.FieldRole, self.lineEdit_8)
        self.lineEdit_9 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit_9.setObjectName(_fromUtf8("lineEdit_9"))
        self.formLayout_2.setWidget(3, QtGui.QFormLayout.FieldRole, self.lineEdit_9)
        self.lineEdit_10 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit_10.setObjectName(_fromUtf8("lineEdit_10"))
        self.formLayout_2.setWidget(4, QtGui.QFormLayout.FieldRole, self.lineEdit_10)
        self.lineEdit_11 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit_11.setObjectName(_fromUtf8("lineEdit_11"))
        self.formLayout_2.setWidget(5, QtGui.QFormLayout.FieldRole, self.lineEdit_11)
        self.lineEdit_12 = QtGui.QLineEdit(self.gridLayoutWidget_3)
        self.lineEdit_12.setObjectName(_fromUtf8("lineEdit_12"))
        self.formLayout_2.setWidget(2, QtGui.QFormLayout.FieldRole, self.lineEdit_12)
        self.label_11 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_11.setObjectName(_fromUtf8("label_11"))
        self.formLayout_2.setWidget(3, QtGui.QFormLayout.LabelRole, self.label_11)
        self.label_12 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_12.setObjectName(_fromUtf8("label_12"))
        self.formLayout_2.setWidget(4, QtGui.QFormLayout.LabelRole, self.label_12)
        self.label_13 = QtGui.QLabel(self.gridLayoutWidget_3)
        self.label_13.setObjectName(_fromUtf8("label_13"))
        self.formLayout_2.setWidget(5, QtGui.QFormLayout.LabelRole, self.label_13)
        self.gridLayout_3.addLayout(self.formLayout_2, 0, 3, 1, 1)
        FreeIMUCal.setCentralWidget(self.centralwidget)
        self.statusbar = QtGui.QStatusBar(FreeIMUCal)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        FreeIMUCal.setStatusBar(self.statusbar)
        self.menubar = QtGui.QMenuBar(FreeIMUCal)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 800, 20))
        self.menubar.setObjectName(_fromUtf8("menubar"))
        FreeIMUCal.setMenuBar(self.menubar)

        self.retranslateUi(FreeIMUCal)
        QtCore.QMetaObject.connectSlotsByName(FreeIMUCal)

    def retranslateUi(self, FreeIMUCal):
        FreeIMUCal.setWindowTitle(QtGui.QApplication.translate("FreeIMUCal", "FreeIMU Calibration Application", None, QtGui.QApplication.UnicodeUTF8))
        self.label.setText(QtGui.QApplication.translate("FreeIMUCal", "Serial Port:", None, QtGui.QApplication.UnicodeUTF8))
        self.connectButton.setText(QtGui.QApplication.translate("FreeIMUCal", "Connect", None, QtGui.QApplication.UnicodeUTF8))
        self.samplingToggleButton.setText(QtGui.QApplication.translate("FreeIMUCal", "Start Sampling", None, QtGui.QApplication.UnicodeUTF8))
        self.pushButton.setText(QtGui.QApplication.translate("FreeIMUCal", "Calibrate", None, QtGui.QApplication.UnicodeUTF8))
        self.label_2.setText(QtGui.QApplication.translate("FreeIMUCal", "Offset X", None, QtGui.QApplication.UnicodeUTF8))
        self.label_4.setText(QtGui.QApplication.translate("FreeIMUCal", "Offset Y", None, QtGui.QApplication.UnicodeUTF8))
        self.label_3.setText(QtGui.QApplication.translate("FreeIMUCal", "Offset Z", None, QtGui.QApplication.UnicodeUTF8))
        self.label_5.setText(QtGui.QApplication.translate("FreeIMUCal", "Scale X", None, QtGui.QApplication.UnicodeUTF8))
        self.label_6.setText(QtGui.QApplication.translate("FreeIMUCal", "Scale Y", None, QtGui.QApplication.UnicodeUTF8))
        self.label_7.setText(QtGui.QApplication.translate("FreeIMUCal", "Scale Z", None, QtGui.QApplication.UnicodeUTF8))
        self.label_8.setText(QtGui.QApplication.translate("FreeIMUCal", "Offset X", None, QtGui.QApplication.UnicodeUTF8))
        self.label_9.setText(QtGui.QApplication.translate("FreeIMUCal", "Offset Y", None, QtGui.QApplication.UnicodeUTF8))
        self.label_10.setText(QtGui.QApplication.translate("FreeIMUCal", "Offset Z", None, QtGui.QApplication.UnicodeUTF8))
        self.label_11.setText(QtGui.QApplication.translate("FreeIMUCal", "Scale X", None, QtGui.QApplication.UnicodeUTF8))
        self.label_12.setText(QtGui.QApplication.translate("FreeIMUCal", "Scale Y", None, QtGui.QApplication.UnicodeUTF8))
        self.label_13.setText(QtGui.QApplication.translate("FreeIMUCal", "Scale Z", None, QtGui.QApplication.UnicodeUTF8))

from pyqtgraph import PlotWidget