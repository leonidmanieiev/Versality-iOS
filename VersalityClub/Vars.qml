/****************************************************************************
**
** Copyright (C) 2019 Leonid Manieiev.
** Contact: leonid.manieiev@gmail.com
**
** This file is part of Versality.
**
** Versality is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** Versality is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with Versality. If not, see <https://www.gnu.org/licenses/>.
**
****************************************************************************/

//general use properties
pragma Singleton
import "."
import QtQuick 2.11
import QtQuick.Window 2.11
import "js/helpFunc.js" as Helper

QtObject
{
    //COLORS
    readonly property color activeCouponColor: "#ff3c3c"
    readonly property color birthdayPickerColor: "#4c1462"
    readonly property color blackColor: "#000000"
    readonly property color chosenPurpleColor: "#631d68"
    readonly property color copyrightBackgroundColor: "#c4c5c6"
    readonly property color dragerLineColor: "#ae4a8c"
    readonly property color errorRed: "RED"
    readonly property color forgetPassPurple: "#a03576"
    readonly property color glowColor: "grey"
    readonly property color mapPromsPopupColor: "#270f3b"
    readonly property color purpleBorderColor: "#441161"
    readonly property color purpleTextColor: "#3a0d5e"
    readonly property color settingspurpleBorderColor: "#84296f"
    readonly property color subCatSelectedColor: "#f0e4ff"
    readonly property color toastGrey: "#76797c"
    readonly property color whiteColor: "#FFFFFF"

    //OTHERS
    readonly property int defaultDay: 15
    readonly property int defaultFontPixelSize: 8
    readonly property int defaultRadius: (isXR || dpr > 2) ? 30 : 20
    readonly property int defaultYear: new Date().getYear()-30
    readonly property real defaultOpacity: 0.8
    readonly property string defaultMonth: '06'

    //REGEX
    readonly property var emailRegEx: /^[A-Za-z0-9]+([.|-]*[A-Za-z0-9])*@{1}([A-Za-z0-9]+[A-Za-z0-9-]*[A-Za-z0-9]+[.])*([A-Za-z0-9]+[A-Za-z0-9-]*[A-Za-z0-9]+)+$/

    //PROMOTION CONSTANTS
    property string markedPromsData: ''
    property string allPromsData: ''
    property string allUniquePromsData: ''
    property string previewPromData: ''
    property string fullPromData: ''

    //COMPANY CONSTANTS
    property string fullCompanyData: ''

    //FOOTERBUTTONS CONSTANTS
    readonly property int footerButtonsFieldHeight: screenHeight*0.125*footerHeightFactor
    readonly property int footerButtonsHeight: screenHeight*0.08*footerHeightFactor

    //HEADERBUTTONS CONSTANTS
    readonly property int headerButtonsHeight: footerButtonsHeight

    //SCREEN CONSTANTS
    readonly property real dpr: isXR ? 2.5 : (Screen.devicePixelRatio > 2 ? 2.2 : Screen.devicePixelRatio)
    readonly property real controlHeightFactor: 3.5
    readonly property real footerHeightFactor: (isXR || dpr > 2) ? 0.8 : 1
    readonly property real iconHeightFactor: (isXR || dpr > 2) ? 0.9 : 1
    readonly property int pageHeight: screenHeight-footerButtonsFieldHeight
    readonly property int companyPageHeight: screenHeight-2*footerButtonsFieldHeight
    readonly property int screenHeight: Screen.height
    readonly property int screenWidth: Screen.width

    //LISTVIEW CONSTANTS
    readonly property int listItemRadius: 20

    //IS DEVICE TYPE iPhone XR
    property bool isXR: (Screen.height*Screen.devicePixelRatio === 1792 &&
                         Screen.width *Screen.devicePixelRatio === 828)

    //INTERNET ACCESS FLAG
    property bool isConnected: false

    //LOCATION ACCESS FLAG
    property bool isLocated: false

    //USER CAME FROM SIGN UP PAGE FLAG
    property bool fromSignUp: false

    //API REQUESTS
    readonly property string domen: "http://club.versality.ru"
    readonly property string main: ":80/"
    readonly property string mobile: ":8080/"
    readonly property string allCats: domen+mobile+"api/categories"
    readonly property string allPromsListViewModel: domen+mobile+"api/promos4?"
    readonly property string allPromsTilesModel: domen+mobile+"api/promos1?"
    readonly property string companyInfo: domen+mobile+"api/company?"
    readonly property string promFullViewModel: domen+mobile+"api/promos3?"
    readonly property string promPreViewModel: domen+mobile+"api/promos2?"
    readonly property string userActivateProm: domen+mobile+"api/user/activate?"
    readonly property string userChangePass: domen+mobile+"api/user/set-pass?"
    readonly property string userInfo: domen+mobile+"api/user?"
    readonly property string userLogin: domen+main+"api/login?"
    readonly property string userMarkProm: domen+mobile+"api/user/mark?"
    readonly property string userMarkedProms: domen+mobile+"api/user/marked?"
    readonly property string userResetPass: domen+mobile+"api/user/reset-pass?"
    readonly property string userSelectCats: domen+mobile+"api/user/categories?"
    readonly property string userSignup: domen+main+"api/register?"
    readonly property string userUnmarkProm: domen+mobile+"api/user/unmark?"

    //POPUP TEXT CONSTS
    readonly property string estabLocationMethodErr: "Ошибка установки метода определения местоположения"
    readonly property string getCloserToProm: "Подойдите ближе к акции"
    readonly property string nmeaConnectionViaSocketErr: "Ошибка подключения к источнику NMEA через socket"
    readonly property string noFavouriteProms: "У Вас нет избранных акций"
    readonly property string noInternetConnection: "Нет соединения с интернетом"
    readonly property string noLocationPrivileges: "Нет привилегий на получение местоположения"
    readonly property string noPromsFromCompany: "У компании нет акций"
    readonly property string noSuitablePromsNearby: "Рядом нет подходящих для Вас акций"
    readonly property string smthWentWrong: "Что-то пошло не так, попробуйте позже"
    readonly property string turnOnLocationAndWait: "Включите определение местоположения и ждите закрытия popup"
    readonly property string unableToGetLocation: "Невозможно получить местоположение"
    readonly property string unknownPosSrcErr: "Неизвестная ошибка PositionSource"

    //TEXT CONSTS
    readonly property string activateCoupon: "АКТИВИРОВАТЬ КУПОН"
    readonly property string activateCouponHelpText: "Для активации акции\nназовите код Вашего купона:"
    readonly property string almostDone: "Все почти готово..."
    readonly property string appInfoTitle: "Информация\nо приложении"
    readonly property string appSiteLink: "http://club.versality.ru"
    readonly property string appSiteName: "club.versality.ru"
    readonly property string back: "Назад"
    readonly property string backToPromotion: "Назад к акции"
    readonly property string backToPromsPicking: "Назад к выбору акций"
    readonly property string birthday: "Дата рождения:"
    readonly property string birthdayMask: "00.00.0000"
    readonly property string changePass: "Изменить пароль:"
    readonly property string checkYourEmail: "(ПРОВЕРЬТЕ ВАШУ ПОЧТУ)"
    readonly property string choose: "ВЫБОР"
    readonly property string chooseCats: "Выберите\nинтересные Вам категории:"
    readonly property string closestAddress: "БЛИЖАЙШИЙ КО МНЕ АДРЕС"
    readonly property string email: "E-mail:"
    readonly property string emailPlaceHolder: "E-MAIL"
    readonly property string emailPlaceHolderEnter: "Введите Ваш E-mail"
    readonly property string enterCode: "ВВЕДИТЕ КОД"
    readonly property string enterName: "ВВЕДИТЕ ИМЯ"
    readonly property string enterNewPass: "ВВЕДИТЕ НОВЫЙ ПАРОЛЬ"
    readonly property string enterYourPass: "ВВЕДИТЕ ВАШ ПАРОЛЬ"
    readonly property string everythingIsClearStart: "Все понятно, начать работу!"
    readonly property string firstHelpText: "В самом начале рекомендуем\nперейти в настройки\nи выбрать интересные Вам акции"
    readonly property string forgetPass: "ЗАБЫЛ ПАРОЛЬ"
    readonly property string incorrectEmail: "Некорректный E-mail"
    readonly property string login: "ВОЙТИ"
    readonly property string logout: "ВЫЙТИ ИЗ АККАУНТА"
    readonly property string m_f: "М/Ж"
    readonly property string mapPageId: "mapPage"
    readonly property string more: "ПОДРОБНЕЕ"
    readonly property string nameNotNecessary: "Имя (не обязательно):"
    readonly property string openCompanyCard: "ОТКРЫТЬ КАРТОЧКУ КОМПАНИИ"
    readonly property string pass: "Пароль:"
    readonly property string passReset: "ВОССТАНОВКА ПАРОЛЯ"
    readonly property string proceed: "Готово"
    readonly property string profileSettings: "Настройки\nпрофиля"
    readonly property string promotionPageId: "promotionPage"
    readonly property string save: "СОХРАНИТЬ"
    readonly property string saveAndBackToSetting: "СОХРАНИТЬ\nИ ВЕРНУТЬСЯ К НАСТРОЙКАМ"
    readonly property string secondHelpText: "Все акции Вы можете смотреть\nв виде списка или на карте города"
    readonly property string sex: "Пол:"
    readonly property string showListView: "Показать в виде списка"
    readonly property string showOnMap: "Показать на карте"
    readonly property string signup: "ЗАРЕГИСТРИРОВАТЬСЯ"
    readonly property string signupNoun: "Регистрация"
    readonly property string submit: "ПОДТВЕРДИТЬ"
    readonly property string thirdHelpText: "Понравившиеся акции Вы можете\nдобавить в список «Мне понравилось»\nи возвращаться к ним позже"
    readonly property string userLocationIsNAN: "user location is NaN"

    //FONTS
    readonly property string regularFont: "../fonts/Roboto-Regular.ttf"
    readonly property string mediumFont: "../fonts/Roboto-Medium.ttf"
    readonly property string boldFont: "../fonts/Roboto-Bold.ttf"
}
