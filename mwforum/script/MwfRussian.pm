#------------------------------------------------------------------------------
#    mwForum - Web-based discussion forum
#    Copyright (c) 1999-2005 Markus Wichitill
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#------------------------------------------------------------------------------

package MwfRussian;
use utf8;
use strict;
use warnings;
no warnings qw(uninitialized redefine);
our ($VERSION, $lng);
$VERSION = "2.12.0";

# Default to English for missing strings
require MwfEnglish;
%$lng = %$MwfEnglish::lng;

#------------------------------------------------------------------------------

# Language module meta information
$lng->{author}       = "FtoR, Petr Kuznetsov";

#------------------------------------------------------------------------------

# Common strings
$lng->{comUp}        = "Вверх";
$lng->{comUpTT}      = "На уровень выше";
$lng->{comPgTtl}     = "Страница";
$lng->{comPgPrev}    = "Предыдущая";
$lng->{comPgPrevTT}  = "На предыдущую страницу";
$lng->{comPgNext}    = "Следующая";
$lng->{comPgNextTT}  = "На следующую станицу";
$lng->{comEnabled}   = "доступно";
$lng->{comDisabled}  = "недоступно";
$lng->{comHidden}    = "(скрыто)";
$lng->{comBoardList} = "Форум";
$lng->{comBoardGo}   = "Вперед";
$lng->{comNewUnrd}   = "Н/Н";
$lng->{comNewUnrdTT} = "Новые/Непрочтенные";
$lng->{comNewRead}   = "Н/-";
$lng->{comNewReadTT} = "Новые/Прочтенные";
$lng->{comOldUnrd}   = "-/Н";
$lng->{comOldUnrdTT} = "Старые/Непрочтенные";
$lng->{comOldRead}   = "-/-";
$lng->{comOldReadTT} = "Старые/Прочтенные";
$lng->{comAnswer}    = "О";
$lng->{comAnswerTT}  = "С ответми";
$lng->{comShowNew}   = "Новые";
$lng->{comShowNewTT} = "Показать новые сообщения";
$lng->{comShowUnr}   = "Непрочтенные";
$lng->{comShowUnrTT} = "Показать непрочтенные сообщения";
$lng->{comShowTdo}   = "Сохраненные";
$lng->{comShowTdoTT} = "Показать сообщения, сохраненные в Вашей папке";
$lng->{comFeeds}     = "RSS/Atom";
$lng->{comFeedsTT}   = "Показать вывод в форматах RSS/Atom";
$lng->{comCaptcha}   = "Защита подписью (только для незарегистрированных пользователей): ведите шесть латинских заглавных букв, изображенных ниже в искаженном виде:";
$lng->{comCptImaBot} = "Я робот";
$lng->{comCptImaMan} = "Я человек";


# Header
$lng->{hdrForum}     = "Форум";
$lng->{hdrForumTT}   = "К списку всех разделов форума";
$lng->{hdrHomeTT}    = "Главная страница сайта";
$lng->{hdrOptions}   = "Настройки";
$lng->{hdrOptionsTT} = "Изменение информации о себе и настроек, подписка";
$lng->{hdrHelp}      = "Справка";
$lng->{hdrHelpTT}    = "Справка, Часто задаваемые вопросы";
$lng->{hdrSearch}    = "Поиск";
$lng->{hdrSearchTT}  = "Поиск сообщений по ключевым словам";
$lng->{hdrChat}      = "Чат";
$lng->{hdrChatTT}    = "Зайти в чат";
$lng->{hdrMsgs}      = "Переписка";
$lng->{hdrMsgsTT}    = "Папка личных сообщений";
$lng->{hdrBlog}      = "Мой журнал";
$lng->{hdrBlogTT}    = "Ваш личный журнал для записей (Блог)";
$lng->{hdrLogin}     = "Вход";
$lng->{hdrLoginTT}   = "Вход со своим именем и паролем";
$lng->{hdrLogout}    = "Забыть пароль";
$lng->{hdrLogoutTT}  = "Сбросить данные авторизации";
$lng->{hdrReg}       = "Регистрация";
$lng->{hdrRegTT}     = "Получить учетную запись на форуме";
$lng->{hdrNoLogin}   = "Нажмите Вход или Регистрация если хотите присоединиться к сообществу";
$lng->{hdrWelcome}   = "Приветствуем,";

# Forum page
$lng->{frmTitle}     = "Форум";
$lng->{frmMarkOld}   = "Пометить как старые";
$lng->{frmMarkOldTT} = "Пометить все сообщения как старые";
$lng->{frmMarkRd}    = "Пометить как прочитанные";
$lng->{frmMarkRdTT}  = "Пометить все сообщения как прочитанные";
$lng->{frmUsers}     = "Участники";
$lng->{frmUsersTT}   = "Показать список участников";
$lng->{frmAttach}    = "Файлы";
$lng->{frmAttachTT}  = "Показать список файлов";
$lng->{frmInfo}      = "Подробности";
$lng->{frmInfoTT}    = "Подробно о форуме";
$lng->{frmNotTtl}    = "Повестки";
$lng->{frmNotDelB}   = "Удалить повестки";
$lng->{frmCtgCollap} = "Свернуть";
$lng->{frmCtgExpand} = "Свернуть категорию";
$lng->{frmPosts}     = "Сообщений";
$lng->{frmLastPost}  = "Дата и время";
$lng->{frmNew}       = "Новые";
$lng->{frmNoBoards}  = "нет отображаемых разделов.";
$lng->{frmStats}     = "Статистика";
$lng->{frmOnlUsr}    = "На линии";
$lng->{frmOnlUsrTT}  = "Участник на линии за последние 5 мин.";
$lng->{frmNewUsr}    = "Новые";
$lng->{frmNewUsrTT}  = "Участник, зарегистрированный в течение последних 5 дней";
$lng->{frmBdayUsr}   = "День рождения";
$lng->{frmBdayUsrTT} = "У этого участника сегодня день рождения";
$lng->{frmBlgPst}    = "Журналы";
$lng->{frmBlgPstTT}  = "Журналы с новыми записями";
$lng->{frmAdmin}     = "Управление";

# Forum info page
$lng->{fifTitle}     = "Форум";
$lng->{fifGenTtl}    = "Основная информация";
$lng->{fifGenAdmEml} = "Почтовый адрес администратора";
$lng->{fifGenAdmins} = "Администраторы";
$lng->{fifGenTZone}  = "Часовой пояс";
$lng->{fifGenVer}    = "Версия форума";
$lng->{fifGenLang}   = "Языки";
$lng->{fifStsTtl}    = "Статистика";
$lng->{fifStsUsrNum} = "Участники";
$lng->{fifStsTpcNum} = "Темы";
$lng->{fifStsPstNum} = "Сообщения";
$lng->{fifStsHitNum} = "Просмотрено тем";

# New/unread/reply/todo overview page
$lng->{ovwTitleNew}  = "Новые сообщения";
$lng->{ovwTitleUnr}  = "Непрочитанные сообщения";
$lng->{ovwTitleTdo}  = "Список сохраненного";
$lng->{ovwTitleBlg}  = "Новые записи в журнале";
$lng->{ovwMarkOld}   = "Пометить как старые";
$lng->{ovwMarkOldTT} = "Пометить все сообщения как старые";
$lng->{ovwMarkRd}    = "Пометить как прочитанные";
$lng->{ovwMarkRdTT}  = "Пометить все сообщения как прочитанные";
$lng->{ovwBlogs}     = "Журналы";
$lng->{ovwBlogsTT}   = "Показать новые записи в журналах";
$lng->{ovwTdoRemove} = "Удалить запись";
$lng->{ovwEmpty}     = "Не найдено таких сообщений.";
$lng->{ovwMaxCutoff} = "Добавочные сообщения стерты, чтобы уменьшить размер страницы.";

# Board page
$lng->{brdTitle}     = "Раздел";
$lng->{brdNewTpc}    = "Новая тема";
$lng->{brdNewTpcTT}  = "Начать новую тему";
$lng->{brdInfo}      = "Подробности";
$lng->{brdInfoTT}    = "Подробная информация о разделе";
$lng->{brdPrev}      = "Предыдущий";
$lng->{brdPrevTT}    = "Перейти к предыдущему разделу";
$lng->{brdNext}      = "Следующий";
$lng->{brdNextTT}    = "Перейти к следующему разделу";
$lng->{brdTopic}     = "Тема";
$lng->{brdPoster}    = "Автор";
$lng->{brdPosts}     = "Сообщений";
$lng->{brdLastPost}  = "Дата и время";
$lng->{brdLocked}    = "З";
$lng->{brdLockedTT}  = "Закрытый раздел";
$lng->{brdInvis}     = "Н";
$lng->{brdInvisTT}   = "Невидимый раздел";
$lng->{brdPoll}      = "Г";
$lng->{brdPollTT}    = "Голосование";
$lng->{brdNew}       = "новый";
$lng->{brdAdmin}     = "Управление";
$lng->{brdAdmRep}    = "Доносы";
$lng->{brdAdmRepTT}  = "Показать сообщения, на которые были написаны доносы";
$lng->{brdAdmMbr}    = "Привилегированные";
$lng->{brdAdmMbrTT}  = "Добавление / удаление привилегий";
$lng->{brdAdmGrp}    = "Клубы";
$lng->{brdAdmGrpTT}  = "Изменение клубных настроек";
$lng->{brdAdmOpt}    = "Настройки";
$lng->{brdAdmOptTT}  = "Изменение настроек раздела";
$lng->{brdAdmDel}    = "Удаление";
$lng->{brdAdmDelTT}  = "Удалить раздел";

# Board info page
$lng->{bifTitle}     = "Раздел";
$lng->{bifOptTtl}    = "Настройки";
$lng->{bifOptDesc}   = "Описание";
$lng->{bifOptLock}   = "Блокировка";
$lng->{bifOptLockT}  = "дней без новых сообщений в теме, по прошествии которых тема закрывается автоматически";
$lng->{bifOptExp}    = "Чистка";
$lng->{bifOptExpT}   = "дней без новых сообщений в теме, по прошествии которых тема автоматически удаляется";
$lng->{bifOptAttc}   = "Файлы";
$lng->{bifOptAttcY}  = "Подгрузка файлов к сообщениям разрешена";
$lng->{bifOptAttcN}  = "Подгрузка файлов к сообщениям запрещена";
$lng->{bifOptAprv}   = "Редактирование";
$lng->{bifOptAprvY}  = "Сообщения должны быть проверены перед публикацией";
$lng->{bifOptAprvN}  = "Сообщения публикуются сразу, без предварительной проверки";
$lng->{bifOptPriv}   = "Доступ к чтению";
$lng->{bifOptPriv0}  = "Все посетители увидят раздел";
$lng->{bifOptPriv1}  = "Только администраторы/редакторы увидят раздел";
$lng->{bifOptPriv2}  = "Только участники увидят раздел";
$lng->{bifOptAnnc}   = "Возможность публикации";
$lng->{bifOptAnnc0}  = "Все участники смогут писать сообщения";
$lng->{bifOptAnnc1}  = "Только администраторы/редакторы/члены клуба смогут писать сообщения";
$lng->{bifOptAnnc2}  = "Только администраторы/редакторы/члены клуба смогут начинать новые темы, все участники смогут ответить";
$lng->{bifOptUnrg}   = "Регистрация";
$lng->{bifOptUnrgY}  = "Для написания сообщений регистрация не требуется";
$lng->{bifOptUnrgN}  = "Для написания сообщений требуется регистрация";
$lng->{bifOptAnon}   = "Анонимность";
$lng->{bifOptAnonY}  = "Сообщения анонимны";
$lng->{bifOptAnonN}  = "Сообщения не анонимны";
$lng->{bifOptFlat}   = "Объемность форума";
$lng->{bifOptFlatY}  = "Сообщения расположены на одном вертикальном уровне (плоско) внутри тем";
$lng->{bifOptFlatN}  = "Темы имеют древовидную структуру сообщений";
$lng->{bifAdmsTtl}   = "Модераторы";
$lng->{bifMbrsTtl}   = "Члены клуба";
$lng->{bifStatTtl}   = "Статистика";
$lng->{bifStatTPst}  = "Сообщения";
$lng->{bifStatLPst}  = "Последнее сообщение";

# Topic page
$lng->{tpcTitle}     = "Тема";
$lng->{tpcBlgTitle}  = "Тема в журнале";
$lng->{tpcHits}      = "просмотра";
$lng->{tpcTag}       = "Маркер";
$lng->{tpcTagTT}     = "Установить маркер темы";
$lng->{tpcSubs}      = "Подписка";
$lng->{tpcSubsTT}    = "Активировать подписку на тему";
$lng->{tpcPolAdd}    = "Голосование";
$lng->{tpcPolAddTT}  = "Добавить голосование к теме";
$lng->{tpcPolDel}    = "Удаление";
$lng->{tpcPolDelTT}  = "Удалить голосование";
$lng->{tpcPolLock}   = "Закрыть";
$lng->{tpcPolLockTT} = "Закончить голосование (необратимо)";
$lng->{tpcPolTtl}    = "Голосование";
$lng->{tpcPolLocked} = "(Закрыто)";
$lng->{tpcPolVote}   = "Голосовать";
$lng->{tpcPolShwRes} = "Результат";
$lng->{tpcRevealTT}  = "Показать скрытые сообщения";
$lng->{tpcHidTtl}    = "Скрытые сообщения";
$lng->{tpcHidIgnore} = "(исключено) ";
$lng->{tpcHidUnappr} = "(не одобрено) ";
$lng->{tpcPrev}      = "Предыдущая";
$lng->{tpcPrevTT}    = "Перейти к предыдущей теме";
$lng->{tpcNext}      = "Следующая";
$lng->{tpcNextTT}    = "Перейти к следующей теме";
$lng->{tpcApprv}     = "Одобрить";
$lng->{tpcApprvTT}   = "Опубликовать сообщение для участников";
$lng->{tpcReport}    = "Админам!";
$lng->{tpcReportTT}  = "Донести о сообщении редакторам";
$lng->{tpcTodo}      = "Сохранить";
$lng->{tpcTodoTT}    = "Сохранить сообщение в свой список";
$lng->{tpcBranch}    = "Ветвь";
$lng->{tpcBranchTT}  = "Отделить/перенести/удалить ветвь обсуждения, начиная с этого сообщения";
$lng->{tpcEdit}      = "Правка";
$lng->{tpcEditTT}    = "Изменить текст сообщения";
$lng->{tpcDelete}    = "Удалить";
$lng->{tpcDeleteTT}  = "Стереть сообщение";
$lng->{tpcAttach}    = "Файл";
$lng->{tpcAttachTT}  = "Закачать/удалить файл к сообщению";
$lng->{tpcReply}     = "Ответить";
$lng->{tpcReplyTT}   = "Ответить на сообщение";
$lng->{tpcQuote}     = "Цитата";
$lng->{tpcQuoteTT}   = "Ответить на сообщение, используя цитирование";
$lng->{tpcBrnCollap} = "Свернуть ветвь";
$lng->{tpcBrnExpand} = "Развернуть ветвь";
$lng->{tpcNxtPst}    = "Следующее";
$lng->{tpcNxtPstTT}  = "Перейти к следующему новому или непрочитанному сообщению";
$lng->{tpcParent}    = "Предшествующее";
$lng->{tpcParentTT}  = "Перейти к предшествующему сообщению";
$lng->{tpcInvis}     = "Н";
$lng->{tpcInvisTT}   = "Невидимое";
$lng->{tpcBrdAdmTT}  = "Редактор";
$lng->{tpcAttText}   = "Файл:";
$lng->{tpcAdmStik}   = "Сделать главной";
$lng->{tpcAdmUnstik} = "Сделать обычной";
$lng->{tpcAdmLock}   = "Закрыть";
$lng->{tpcAdmUnlock} = "Открыть";
$lng->{tpcAdmMove}   = "Переместить";
$lng->{tpcAdmMerge}  = "Соединить";
$lng->{tpcAdmDelete} = "Удалить";
$lng->{tpcBy}        = "От";
$lng->{tpcOn}        = "Дата";
$lng->{tpcEdited}    = "Исправлено";
$lng->{tpcLocked}    = "(закрыто)";

# Topic subscription page
$lng->{tsbTitle}     = "Тема";
$lng->{tsbSubTtl}    = "Подписка на тему";
$lng->{tsbSubT}      = "Если подпишитесь на эту тему, на Ваш почтовый ящик, указанный при регистрации, будут регулярно отправляться все новые сообщения (частота зависит от настроек форума).";
$lng->{tsbSubB}      = "Подписаться";
$lng->{tsbUnsubTtl}  = "Отмена подписки";
$lng->{tsbUnsubB}    = "Отписаться";

# Add poll page
$lng->{aplTitle}     = "Добавить голосование";
$lng->{aplPollTitle} = "Заголовок голосования или опроса";
$lng->{aplPollOpts}  = "Установки";
$lng->{aplPollMulti} = "Разрешить голосовать сразу за несколько пунктов анкеты";
$lng->{aplPollNote}  = "Внимание: вы не можете редактировать голосование, и не сможете удалить его после внесения первого голоса, так что, пожалуйста, проверьте заголовок и пункты перед публикацией голосования.";
$lng->{aplPollAddB}  = "Публиковать";

# Add todo page
$lng->{atdTitle}     = "Сообщение";
$lng->{atdTodoTtl}   = "Добавить сообщение в список сохраненных";
$lng->{atdTodoT}     = "Если вы хотите ответить или хотя бы посмотреть на это сообщение позже не рискуя забыть об этом, вы можете сохранить его в свой личный список.";
$lng->{atdTodoB}     = "Сохранить";

# Add report page
$lng->{arpTitle}     = "Сообщение";
$lng->{arpRepTtl}    = "Донести на сообщение администраторам и редакторам";
$lng->{arpRepT}      = "Если Вы считаете, что содержимое этого сообщения нарушает правила этого форума, вы можете добавить его в специальный список сообщений, который увидят все администраторы и редакторы";
$lng->{arpRepReason} = "Причина доноса:";
$lng->{arpRepB}      = "Донести";

# Report list page
$lng->{repTitle}     = "Доносы на сообщения";
$lng->{repBy}        = "Донос от";
$lng->{repOn}        = "На";
$lng->{repTopic}     = "Тема";
$lng->{repPoster}    = "Отправитель";
$lng->{repPosted}    = "Отправлено";
$lng->{repDeleteB}   = "Удалить донос";
$lng->{repEmpty}     = "Нет доносов.";

# Reply page
$lng->{rplTitle}     = "Тема";
$lng->{rplBlgTitle}  = "Запись в журнале";
$lng->{rplReplyTtl}  = "Ответ на сообщение";
$lng->{rplReplyBody} = "Текст";
$lng->{rplReplyNtfy} = "Посылать уведомление об ответах на e-mail";
$lng->{rplReplyResp} = "В ответ на";
$lng->{rplReplyB}    = "Ответить";
$lng->{rplReplyPrvB} = "Предпросмотр";
$lng->{rplPrvTtl}    = "Предпросмотр";
$lng->{rplEmailSbj}  = "Уведомление об ответе";
$lng->{rplEmailFrm}  = "Форум: ";
$lng->{rplEmailBrd}  = "Раздел: ";
$lng->{rplEmailTpc}  = "Тема: ";
$lng->{rplEmailUsr}  = "Участник: ";
$lng->{rplEmailUrl}  = "Адрес: ";
$lng->{rplEmailT2}   = "Это автоматическое сообщение, написанное роботом форума.\nПожалуйста, не отвечайте роботу, отвечайте людям в форуме.";

# New topic page
$lng->{ntpTitle}     = "Раздел";
$lng->{ntpBlgTitle}  = "Журнал";
$lng->{ntpTpcTtl}    = "Начать новую тему";
$lng->{ntpTpcSbj}    = "Заголовок";
$lng->{ntpTpcBody}   = "Текст";
$lng->{ntpTpcNtfy}   = "Высылать уведомления об ответах на e-mail";
$lng->{ntpTpcB}      = "Отправить";
$lng->{ntpTpcPrvB}   = "Предпросмотр";
$lng->{ntpPrvTtl}    = "Предпросмотр";

# Post edit page
$lng->{eptTitle}     = "Сообщение";
$lng->{eptEditTtl}   = "Правка сообщения";
$lng->{eptEditSbj}   = "Тема";
$lng->{eptEditBody}  = "Текст";
$lng->{eptEditB}     = "Исправить";
$lng->{eptDeleted}   = "[удалено]";

# Post attachment page
$lng->{attTitle}     = "Сообщение";
$lng->{attUplTtl}    = "Файл";
$lng->{attUplFile}   = "Файл (макс. размер [[bytes]] байт)";
$lng->{attUplEmbed}  = "Автопоказ (только JPG, PNG и GIF, изображения)";
$lng->{attUplB}      = "Закачать";
$lng->{attAttTtl}    = "Файлы";
$lng->{attAttDelB}   = "Удалить";
$lng->{attAttTglB}   = "Отключить автопоказ";

# User info page
$lng->{uifTitle}     = "Участник";
$lng->{uifListPst}   = "Сообщения";
$lng->{uifListPstTT} = "Показать сообщения от этого участника";
$lng->{uifBlog}      = "Журнал";
$lng->{uifBlogTT}    = "Показать журнал этого участника";
$lng->{uifMessage}   = "Отправить сообщение";
$lng->{uifMessageTT} = "Отправить личное сообщение этому участнику";
$lng->{uifIgnore}    = "Исключить";
$lng->{uifIgnoreTT}  = "Исключить этого участника";
$lng->{uifProfTtl}   = "Профиль";
$lng->{uifProfRName} = "Реальное имя";
$lng->{uifProfBdate} = "День рождения";
$lng->{uifProfEml}   = "Email";
$lng->{uifProfPage}  = "Сайт";
$lng->{uifProfOccup} = "Род занятий";
$lng->{uifProfHobby} = "Увлечения";
$lng->{uifProfLocat} = "Откуда";
$lng->{uifProfGeoIp} = "Страна по IP";
$lng->{uifProfIcq}   = "ICQ #, Jabber ID и т.п.";
$lng->{uifProfAvat}  = "Портрет";
$lng->{uifGrpMbrTtl} = "Состоит в клубе";
$lng->{uifBrdAdmTtl} = "Редактор раздела";
$lng->{uifBrdMbrTtl} = "Привилегии в разделе";
$lng->{uifBrdSubTtl} = "Подписка на раздел";
$lng->{uifStatTtl}   = "Статистика";
$lng->{uifStatRank}  = "Уровень";
$lng->{uifStatPNum}  = "Сообщений";
$lng->{uifStatBNum}  = "Записей в журнале";
$lng->{uifStatRegTm} = "Зарегистрирован";
$lng->{uifStatLOTm}  = "Последнее посещение";
$lng->{uifStatLRTm}  = "Последний просмотр";
$lng->{uifStatLIp}   = "Последний IP";

# User list page
$lng->{uliTitle}     = "Список участников";
$lng->{uliLfmTtl}    = "Формат списка";
$lng->{uliLfmSearch} = "Поиск";
$lng->{uliLfmField}  = "Поле";
$lng->{uliLfmSort}   = "Сортировка";
$lng->{uliLfmSrtNam} = "Имя";
$lng->{uliLfmSrtUid} = "ID участника";
$lng->{uliLfmSrtFld} = "Поле";
$lng->{uliLfmOrder}  = "Порядок";
$lng->{uliLfmOrdAsc} = "Возр";
$lng->{uliLfmOrdDsc} = "Убыв";
$lng->{uliLfmHide}   = "Скрыть пустые";
$lng->{uliLfmListB}  = "Список";
$lng->{uliLstName}   = "Имя участника";

# User login page
$lng->{lgiTitle}     = "Участник";
$lng->{lgiLoginTtl}  = "Вход";
$lng->{lgiLoginT}    = "Введите Ваше имя и пароль, чтобы войти. Если Вы забыли имя, вместо него можете ввести почтовый ящик, указанный при регистрации. Если у вас еще нет имени на форуме, можете <a href='user_register.pl'>зарегистрироваться</a>. Если вы только что зарегистрировались, вы должны получить информацию для входа в форум в письме на тот адрес, который вы указали при регистрации.";
$lng->{lgiLoginName} = "Имя";
$lng->{lgiLoginPwd}  = "Пароль";
$lng->{lgiLoginB}    = "Войти";
$lng->{lgiFpwTtl}    = "Если пароль забыт";
$lng->{lgiFpwT}      = "Если вы потеряли пароль, введите ваше имя на форуме и нажмите Отправить запрос чтобы получить одноразовую ссылку для входа, которая будет отправлена на почтовый адрес, указанный при регистрации участника. Если вы и имя тоже забыли, можете ввести этот самый почтовый адрес. Не следует использовать эту функцию несколько раз подряд, если письмо не приходит немедленно, так как лишь последняя одноразовая ссылка будет верной.";
$lng->{lgiFpwB}      = "Отправить запрос";
$lng->{lgiFpwMlSbj}  = "Если пароль забыт";
$lng->{lgiFpwMlT}    = "Кликните по этой одноразовой ссылке для входа в форум, чтобы войти без своего пароля. Затем вы сразу же сможете выбрать вместо него новый.\n\По соображениям безопасности, одноразовая ссылка для входа может быть использована в течение ограниченного периода времени после отправки запроса. Кроме того, только последняя ссылка будет верной, если вы отправили запрос несколько раз.";
$lng->{lgiFpwMlRq}   = "Кто запросил информацию";
$lng->{lgiFpwMlRqIP} = "IP адрес: ";
$lng->{lgiFpwMlRqUA} = "Браузер: ";

# User registration page
$lng->{regTitle}     = "Участник";
$lng->{regRegTtl}    = "Регистрация участника";
$lng->{regRegT}      = "Пожалуйста, введите следующую информацию для регистрации участника на форуме. Если Вы уже зарегистрированы, можете войти на <a href='user_login.pl'>странице входа</a>. Если после регистрации и входа на форум под своим именем и паролем вы укажете действующий e-mail в 'настройках', то сможете восстановить забытый пароль в любое время.";
$lng->{regRegName}   = "Имя";
$lng->{regRegEmail}  = "E-mail адрес (должен работать, иначе Вы не получите свой пароль)";
$lng->{regRegEmailV} = "наберите еще раз E-mail адрес для подтверждения";
$lng->{regRegCpt}    = "Пожалуйста, для защиты аккаунта введите шесть заглавных латинских букв, изображенных на картинке в искаженном виде";
$lng->{regRegB}      = "Зарегистрировать";
$lng->{regMailSubj}  = "Регистрация";
$lng->{regMailT}     = "Вы зарегистрировались как участник форума.";
$lng->{regMailName}  = "Имя: ";
$lng->{regMailPwd}   = "Пароль: ";
$lng->{regMailT2}    = "После того, как Вы используете эту информацию для входа, используйте пожалуйста меню 'Настройки' в форуме, чтобы изменить пароль на удобный Вам и для корректировки информации о себе и персонализации форума.";

# User options page
$lng->{uopTitle}     = "Участник";
$lng->{uopPasswd}    = "Пароль";
$lng->{uopPasswdTT}  = "Изменить пароль";
$lng->{uopBoards}    = "Разделы";
$lng->{uopBoardsTT}  = "Конфигурация настроек раздела";
$lng->{uopTopics}    = "Темы";
$lng->{uopTopicsTT}  = "Изменение настроек тем";
$lng->{uopAvatar}    = "Портрет";
$lng->{uopAvatarTT}  = "Выбор картинки для портрета (аватары)";
$lng->{uopIgnore}    = "Исключение";
$lng->{uopIgnoreTT}  = "Исключить других участников";
$lng->{uopOpenPgp}   = "OpenPGP";
$lng->{uopOpenPgpTT} = "Конфигурировать настройки OpenPGP ";
$lng->{uopInfo}      = "Об участнике";
$lng->{uopInfoTT}    = "Показать всю информацию об участнике";
$lng->{uopProfTtl}   = "Профиль";
$lng->{uopProfEml}   = "Email адрес (изменение вступает в силу только после подтверждения)";
$lng->{uopProfEmlV}  = "Ввести Email адрес еще раз (для подтверждения)";
$lng->{uopProfRName} = "Реальное имя";
$lng->{uopProfBdate} = "день рождения (ГГГГ-ММ-ДД либо ММ-ДД)";
$lng->{uopProfPage}  = "Сайт";
$lng->{uopProfOccup} = "Род занятий";
$lng->{uopProfHobby} = "Увлечения";
$lng->{uopProfLocat} = "Откуда";
$lng->{uopProfIcq}   = "ICQ #, Jabber ID и т.п.";
$lng->{uopProfSig}   = "Подпись";
$lng->{uopProfSigLt} = "(макс. 100 знаков, 2 строки)";
$lng->{uopPrefTtl}   = "Основные настройки";
$lng->{uopPrefHdEml} = "Не показывать e-mail";
$lng->{uopPrefPrivc} = "Скрывать нахождение в форуме";
$lng->{uopPrefTmpLg} = "Забывать пароль автоматически, по закрытии браузера";
$lng->{uopPrefSecLg} = "Ограничить вход соединениями SSL (только для специалистов)";
$lng->{uopPrefMnOld} = "Помечать сообщения как старые только вручную";
$lng->{uopPrefNtMsg} = "Получать приватные сообщения на email";
$lng->{uopPrefNt}    = "Получать уведомления об ответах на Ваши сообщения в форуме на e-mail";
$lng->{uopDispTtl}   = "Опции вывода";
$lng->{uopDispLang}  = "Язык";
$lng->{uopDispTimeZ} = "Часовой пояс";
$lng->{uopDispStyle} = "Стиль";
$lng->{uopDispFFace} = "Название шрифта";
$lng->{uopDispFSize} = "Размер шрифта (в пикселах, 0 = по умолчанию)";
$lng->{uopDispIndnt} = "Отступ (1-10%, для формирования древовидной структуры)";
$lng->{uopDispTpcPP} = "Тем на странице (0 = показывать максимум, определенный администратором)";
$lng->{uopDispPstPP} = "Сообщений на странице (0 = показывать максимум, определенный администратором)";
$lng->{uopDispDescs} = "Показывать описания форумов";
$lng->{uopDispDeco}  = "Показывать элементы оформления - титулы, уровни, смайлы";
$lng->{uopDispAvas}  = "Показывать портреты";
$lng->{uopDispImgs}  = "Автопоказ изображений";
$lng->{uopDispSigs}  = "Показывать подписи";
$lng->{uopDispColl}  = "Сворачивать ветви тем без новых/непрочитанных сообщений";
$lng->{uopSubmitTtl} = "Сохранить изменения";
$lng->{uopSubmitB}   = "Сохранить";
$lng->{uopMlChgSubj} = "Изменить Email/Пароль ";
$lng->{uopMlChgT}    = "Вы попытались изменить адрес email, указанный при регистрации. Чтобы убедиться в верности нового адреса, он будет использоваться форумом только после того, как Вы посетите следующую ссылку-подтверждение:";

# User password page
$lng->{pwdTitle}     = "Участник";
$lng->{pwdChgTtl}    = "Сменить пароль";
$lng->{pwdChgT}      = "Никогда не используйте один и тот же пароль для нескольких имен.";
$lng->{pwdChgPwd}    = "Пароль";
$lng->{pwdChgPwdV}   = "Повторите пароль";
$lng->{pwdChgB}      = "Изменить";

# User board options page
$lng->{ubdTitle}     = "Участник";
$lng->{ubdBrdStTtl}  = "Настройки раздела";
$lng->{ubdBrdStSubs} = "Подписка";
$lng->{ubdBrdStHide} = "Скрыть";
$lng->{ubdSubmitTtl} = "Изменить настройки раздела";
$lng->{ubdChgB}      = "Изменить";

# Avatar page
$lng->{avaTitle}     = "Участник";
$lng->{avaUplTtl}    = "Индивидуальный портрет";
$lng->{avaUplFile}   = "изображение в формате JPG/PNG/GIF, макс. размер %s байт, ширина и высота %sx%s пикселей, не анимированная";
$lng->{avaUplResize} = "Не подходящие по размеру иллюстрации будут автоматически изменены, что может сказаться на их качестве.";
$lng->{avaUplUplB}   = "Загрузить";
$lng->{avaUplDelB}   = "Удалить";
$lng->{avaGalTtl}    = "Галерея изображений";
$lng->{avaGalSelB}   = "Выбрать";
$lng->{avaGalDelB}   = "Удалить";

# User ignore page
$lng->{uigTitle}     = "Участник";
$lng->{uigAddT}      = "Если Вы исключаете другого участника, все его приватные сообщения к Вам будут автоматически блокированы, и его сообщения в форуме будут скрыты от Вас (но вы сможете просмотреть их, если захотите).";
$lng->{uigAddTtl}    = "Добавить участника в список исключенных";
$lng->{uigAddUser}   = "Имя";
$lng->{uigAddB}      = "Добавить";
$lng->{uigRemTtl}    = "Удаление участника из списка исключенных";
$lng->{uigRemUser}   = "Имя";
$lng->{uigRemB}      = "Удалить";

# Group info page
$lng->{griTitle}     = "Клуб";
$lng->{griMbrTtl}    = "Члены";
$lng->{griBrdAdmTtl} = "Права редактора раздела";
$lng->{griBrdMbrTtl} = "Права привилегированного участника раздела";

# Board membership page
$lng->{mbrTitle}     = "Раздел";
$lng->{mbrAddTtl}    = "Дать привилегии участнику";
$lng->{mbrAddUser}   = "Имя";
$lng->{mbrAddB}      = "Добавить";
$lng->{mbrRemTtl}    = "Удаление привилегий";
$lng->{mbrRemUser}   = "Имя";
$lng->{mbrRemB}      = "Удалить";

# Board groups page
$lng->{bgrTitle}     = "Раздел";
$lng->{bgrPermTtl}   = "Права";
$lng->{bgrModerator} = "Модератор";
$lng->{bgrMember}    = "Участник";
$lng->{bgrChangeTtl} = "Изменение прав";
$lng->{bgrChangeB}   = "Изменить";

# Topic tag page
$lng->{ttgTitle}     = "Тема";
$lng->{ttgTagTtl}    = "Маркировать тему";
$lng->{ttgTagB}      = "Маркировка";

# Topic move page
$lng->{mvtTitle}     = "Тема";
$lng->{mvtMovTtl}    = "Перенос темы";
$lng->{mvtMovDest}   = "Куда перенести";
$lng->{mvtMovB}      = "Перенести";

# Topic merge page
$lng->{mgtTitle}     = "Тема";
$lng->{mgtMrgTtl}    = "Объединение тем";
$lng->{mgtMrgDest}   = "С чем объединить";
$lng->{mgtMrgDest2}  = "Альтернативный ручной ввод ID (для старых тем, или тем в других разделах)";
$lng->{mgtMrgB}      = "Объединить";

# Branch page
$lng->{brnTitle}     = "Ветвь темы";
$lng->{brnPromoTtl}  = "Привязать к ветви";
$lng->{brnPromoSbj}  = "Название";
$lng->{brnPromoBrd}  = "Раздел";
$lng->{brnPromoLink} = "Добавить сообщения с перекрестными ссылками";
$lng->{brnPromoB}    = "Привязать";
$lng->{brnProLnkBdy} = "ветвь темы перемещена";
$lng->{brnMoveTtl}   = "Перемещение";
$lng->{brnMovePrnt}  = "ID родительского сообщения (может быть в другой теме, 0 = сделать первым сообщением)";
$lng->{brnMoveB}     = "Переместить";
$lng->{brnDeleteTtl} = "Удаление";
$lng->{brnDeleteB}   = "Удалить";

# Search page
$lng->{seaTitle}     = "Поиск";
$lng->{seaTtl}       = "Параметры";
$lng->{seaAdvOpt}    = "Расширенный поиск";
$lng->{seaBoard}     = "Раздел";
$lng->{seaBoardAll}  = "Все разделы";
$lng->{seaWords}     = "Ключевые слова";
$lng->{seaWordsChng} = "Some words and/or characters have been changed or removed, since the fulltext index used for performance reasons doesn't support searching for exactly the expression you have typed. This affects words with less than three characters, certain common words and special characters outside of quoted expressions.";
$lng->{seaUser}      = "Автор";
$lng->{seaMinAge}    = "Минимальный возраст";
$lng->{seaMaxAge}    = "Макс. возраст";
$lng->{seaField}     = "Поле";
$lng->{seaFieldBody} = "Текст";
$lng->{seaFieldSubj} = "Тема";
$lng->{seaSort}      = "Сортировка";
$lng->{seaSortTime}  = "Время";
$lng->{seaSortUser}  = "Автор";
$lng->{seaSortRelev} = "Релевантность";
$lng->{seaOrder}     = "Порядок";
$lng->{seaOrderAsc}  = "Возр.";
$lng->{seaOrderDesc} = "Убыв.";
$lng->{seaShowBody}  = "Показать текст";
$lng->{seaB}         = "Искать";
$lng->{serTopic}     = "Тема";
$lng->{serRelev}     = "Релевантность";
$lng->{serPoster}    = "Автор";
$lng->{serPosted}    = "Опубликовано";
$lng->{serNotFound}  = "По введенному Вами запросу ничего не найдено.";

# Help page
$lng->{hlpTitle}     = "Справка";
$lng->{hlpTxtTtl}    = "Условия и особенности";
$lng->{hlpFaqTtl}    = "Часто задаваемые вопросы";

# Message list page
$lng->{mslTitle}     = "Приватные сообщения";
$lng->{mslSend}      = "Написать сообщение";
$lng->{mslSendTT}    = "Создание приватного сообщения";
$lng->{mslDelAll}    = "Удалить все прочитанные";
$lng->{mslDelAllTT}  = "Удалить все прочитанные и отправленные сообщения";
$lng->{mslInbox}     = "Входящие";
$lng->{mslOutbox}    = "Отправленные";
$lng->{mslFrom}      = "Отправитель";
$lng->{mslTo}        = "Получатель";
$lng->{mslDate}      = "Дата";
$lng->{mslCommands}  = "Действия";
$lng->{mslDelete}    = "Удалить";
$lng->{mslNotFound}  = "Нет приватных сообщений в этом ящике.";
$lng->{mslExpire}    = "Приватные сообщения удаляются через [[days]] дней.";

# Add message page
$lng->{msaTitle}     = "Приватное сообщение";
$lng->{msaSendTtl}   = "Создание приватного сообщения";
$lng->{msaSendRecv}  = "Получатель";
$lng->{msaSendSbj}   = "Заголовок";
$lng->{msaSendTxt}   = "Текст сообщения";
$lng->{msaSendB}     = "Отправить";
$lng->{msaSendPrvB}  = "Предпросмотр";
$lng->{msaPrvTtl}    = "Предпросмотр";
$lng->{msaRefTtl}    = "В ответ на";
$lng->{msaEmailSbj}  = "Уведомление о сообщении";
$lng->{msaEmailTSbj} = "Заголовок: ";
$lng->{msaEmailUsr}  = "Отправитель: ";
$lng->{msaEmailUrl}  = "Ссылка: ";
$lng->{msaEmailT2}   = "Это автоматическое уведомление о сообщении, отправленное роботом форума.\nПожалуйста, не отвечайте роботу, отвечайте людям в форуме.";

# Message page
$lng->{mssTitle}     = "Приватное сообщение";
$lng->{mssDelete}    = "Удалить";
$lng->{mssDeleteTT}  = "Удалить сообщение";
$lng->{mssReply}     = "Ответить";
$lng->{mssReplyTT}   = "Ответить на сообщение";
$lng->{mssQuote}     = "Цитата";
$lng->{mssQuoteTT}   = "Ответить на сообщение, используя цитату";
$lng->{mssFrom}      = "От";
$lng->{mssTo}        = "Кому";
$lng->{mssDate}      = "Дата";
$lng->{mssSubject}   = "Заголовок";

# Blog page
$lng->{blgTitle}     = "Журнал";
$lng->{blgSubject}   = "Запись";
$lng->{blgDate}      = "Дата";
$lng->{blgComment}   = "Комментарии";
$lng->{blgCommentTT} = "Читать комментарии и комментировать";
$lng->{blgExpire}    = "Темы журнала удаляются через [[days]] дней.";

# Chat page
$lng->{chtTitle}     = "Чат";
$lng->{chtRefresh}   = "Обновить";
$lng->{chtRefreshTT} = "Обновить страницу";
$lng->{chtDelAll}    = "Очистить все";
$lng->{chtDelAllTT}  = "Удалить все реплики";
$lng->{chtAddTtl}    = "Высказать реплику";
$lng->{chtAddB}      = "Высказать";
$lng->{chtMsgsTtl}   = "Реплики";

# Attachment list page
$lng->{aliTitle}     = "Список файлов";
$lng->{aliLfmTtl}    = "Формат списка";
$lng->{aliLfmSearch} = "Поиск";
$lng->{aliLfmBoard}  = "Раздел";
$lng->{aliLfmSort}   = "Сортировка";
$lng->{aliLfmSrtFNm} = "Имя файла";
$lng->{aliLfmSrtUNm} = "Имя пользователя";
$lng->{aliLfmSrtPTm} = "Дата";
$lng->{aliLfmOrder}  = "Порядок";
$lng->{aliLfmOrdAsc} = "Возр";
$lng->{aliLfmOrdDsc} = "Убыв";
$lng->{aliLfmGall}   = "Галерея";
$lng->{aliLfmListB}  = "Список";
$lng->{aliLstFile}   = "Имя";
$lng->{aliLstSize}   = "Размер";
$lng->{aliLstPost}   = "Сообщение";
$lng->{aliLstUser}   = "Участник";

# Email subscriptions
$lng->{subSubjBrd}   = "Подписка на раздел";
$lng->{subSubjTpc}   = "Подписка на тему";
$lng->{subTopic}     = "Тема: ";
$lng->{subBy}        = "От: ";
$lng->{subOn}        = "Дата: ";

# Feeds
$lng->{fedTitle}     = "Экспорт";
$lng->{fedAllBoards} = "Все общедоступные разделы";
$lng->{fedAllBlogs}  = "Все журналы/дневники";

# Bounce detection
$lng->{bncWarning}   = "Внимание: Ваш почтовый ящик возвращает/не принимает письма от форума. Пожалуйста, разберитесь, в чем проблема, или форум вынужден будет перестать отправлять вам письма.";

# Confirmation
$lng->{cnfTitle}     = "Подтверждение";
$lng->{cnfDelAllMsg} = "Вы в самом деле хотите удалить все прочитанные сообщения?";
$lng->{cnfDelAllCht} = "Вы в самом деле хотите удалить все реплики из чата?";
$lng->{cnfQuestion}  = "Вы в самом деле хотите удалить";
$lng->{cnfQuestion2} = "?";
$lng->{cnfTypeUser}  = "участник";
$lng->{cnfTypeGroup} = "клуб";
$lng->{cnfTypeCateg} = "категория";
$lng->{cnfTypeBoard} = "раздел";
$lng->{cnfTypeTopic} = "тема";
$lng->{cnfTypePoll}  = "голосование";
$lng->{cnfTypePost}  = "сообщение";
$lng->{cnfTypeMsg}   = "приватное сообщение";
$lng->{cnfDeleteB}   = "Удалить";

# Notification messages
$lng->{notNotify}    = "Оповестить пользователя (чтобы указать причину)";
$lng->{notReason}    = "Причина:";
$lng->{notMsgAdd}    = "[[usrNam]] прислал приватное <a href='[[msgUrl]]'>сообщение</a>.";
$lng->{notPstAdd}    = "[[usrNam]] ответил на <a href='[[pstUrl]]'>сообщение</a>.";
$lng->{notPstEdt}    = "Модератор отредактировал <a href='[[pstUrl]]'>сообщение</a>.";
$lng->{notPstDel}    = "Модератор стер <a href='[[tpcUrl]]'>сообщение</a>.";
$lng->{notTpcMov}    = "Модератор переместил <a href='[[tpcUrl]]'>тему</a>.";
$lng->{notTpcDel}    = "Модератор удалил тему с заголовком \"[[tpcSbj]]\".";
$lng->{notTpcMrg}    = "Модератор склеил тему с другой <a href='[[tpcUrl]]'>темой</a>.";
$lng->{notEmlReg}    = "Добро пожаловать, [[usrNam]]! Для пользования подпиской и уведомлениями, введите свой <a href='[[emlUrl]]'>адрес email</a>.";


# Top bar messages
$lng->{msgReplyPost} = "Ответ отправлен";
$lng->{msgNewPost}   = "Новая тема создана";
$lng->{msgPstChange} = "Сообщение изменено";
$lng->{msgPstDel}    = "Сообщение удалено";
$lng->{msgPstTpcDel} = "Сообщение и тема удалены";
$lng->{msgPstApprv}  = "Сообщение одобрено";
$lng->{msgPstAttach} = "Файл присоединен";
$lng->{msgPstDetach} = "Файл удален";
$lng->{msgPstAttTgl} = "Автопоказ выключен";
$lng->{msgOptChange} = "Настройки изменены";
$lng->{msgPwdChange} = "Пароль изменен";
$lng->{msgAccntReg}  = "Участник зарегистрирован";
$lng->{msgMemberAdd} = "Участник добавлен в клуб";
$lng->{msgMemberRem} = "Участник исключен из клуба";
$lng->{msgTpcDelete} = "Тема удалена";
$lng->{msgTpcStik}   = "Тема сделана главной";
$lng->{msgTpcUnstik} = "Тема сделана обычной";
$lng->{msgTpcLock}   = "Тема закрыта";
$lng->{msgTpcUnlock} = "Тема открыта";
$lng->{msgTpcMove}   = "Тема перемещена";
$lng->{msgTpcMerge}  = "Тема соединена";
$lng->{msgBrnPromo}  = "Ветвь повышена";
$lng->{msgBrnMove}   = "Ветвь перемещена";
$lng->{msgBrnDelete} = "Ветвь удалена";
$lng->{msgPstAddTdo} = "Сообщение сохранено в личный список";
$lng->{msgPstRemTdo} = "Сообщение удалено из личного списка";
$lng->{msgPstAddRep} = "Донос отправлен";
$lng->{msgPstRemRep} = "Донос удален";
$lng->{msgMarkOld}   = "Все сообщения помечены как старые";
$lng->{msgMarkRead}  = "Все сообщения помечены как прочитанные";
$lng->{msgPollAdd}   = "Голосование добавлено";
$lng->{msgPollDel}   = "Голосование удалено";
$lng->{msgPollLock}  = "Голосование завершено";
$lng->{msgPollVote}  = "Вы проголосовали";
$lng->{msgMsgAdd}    = "Приватное сообщение отправлено";
$lng->{msgMsgDel}    = "Приватное сообщение (сообщения) удалено";
$lng->{msgChatAdd}   = "Реплика отправлена в чат";
$lng->{msgChatDel}   = "Реплика (реплики) удалена из чата";
$lng->{msgIgnoreAdd} = "Участник добавлен в список игнорируемых";
$lng->{msgIgnoreRem} = "Участник удален из списка игнорируемых";
$lng->{msgCfgChange} = "Свойства форума изменены";
$lng->{msgEolTpc}    = "В этом направлении больше нет тем";
$lng->{msgTksFgtPwd} = "Email отправлен";
$lng->{msgTkaFgtPwd} = "Вы вошли в форум, теперь можете сменить пароль";
$lng->{msgTkaEmlChg} = "Email адрес подтвержден";
$lng->{msgCronExec}  = "На сервере начато исполнение файла Cron";
$lng->{msgTpcTag}    = "Тема промаркирована";
$lng->{msgTpcSub}    = "Вы подписались на тему";
$lng->{msgTpcUnsub}  = "Вы отписались от темы";
$lng->{msgTpcUnsAll} = "Вы отписались от всех тем";
$lng->{msgNotesDel}  = "Повестки удалены";

# Error messages
$lng->{errDefault}   = "[ошибка - ряд потерян]";
$lng->{errGeneric}   = "Ошибка";
$lng->{errText}      = "Если Вы полагаете, что это действительно ошибка, можете сообщить о ней администратору. Следует включить в письмо точный текст сообщения об ошибке и время, когда она произошла.";
$lng->{errUser}      = "Ошибка участника";
$lng->{errForm}      = "Ошибка формы";
$lng->{errDb}        = "Ошибка базы";
$lng->{errEntry}     = "Ошибка записи базы";
$lng->{errParam}     = "Ошибка параметра CGI ";
$lng->{errConfig}    = "Ошибка свойств";
$lng->{errMail}      = "Ошибка почты";
$lng->{errNote}      = "Замечание";
$lng->{errParamMiss} = "Потерян параметр.";
$lng->{errCatIdMiss} = "Потерян ID категории.";
$lng->{errBrdIdMiss} = "Потерян ID раздела.";
$lng->{errTpcIdMiss} = "Потерян ID темы.";
$lng->{errUsrIdMiss} = "Потерян ID участника.";
$lng->{errGrpIdMiss} = "Потерян ID клуба.";
$lng->{errPstIdMiss} = "Потерян ID сообщения.";
$lng->{errPrtIdMiss} = "Потерян ID исходного сообщения.";
$lng->{errMsgIdMiss} = "Потерян ID приватного сообщения.";
$lng->{errTPIdMiss}  = "Потерян ID темы или сообщения.";
$lng->{errCatNotFnd} = "Категория не существует.";
$lng->{errBrdNotFnd} = "Раздел не существует.";
$lng->{errTpcNotFnd} = "Тема не существует.";
$lng->{errPstNotFnd} = "Сообщение не существует.";
$lng->{errPrtNotFnd} = "Исходное сообщение не существует.";
$lng->{errMsgNotFnd} = "Приватное сообщение не существует.";
$lng->{errUsrNotFnd} = "Участник не существует.";
$lng->{errGrpNotFnd} = "Клуб не существует.";
$lng->{errTktNotFnd} = "Одноразовая ссылка для входа не существует. Только самая последняя запрошенная ссылка верна.";
$lng->{errUsrDel}    = "Запись об участнике больше не существует.";
$lng->{errUsrFake}   = "Недействительная запись об участнике.";
$lng->{errSubEmpty}  = "Поле Тема не заполнено.";
$lng->{errBdyEmpty}  = "Поле Текст не заполнено.";
$lng->{errNamEmpty}  = "Поле Участник не заполнено.";
$lng->{errPwdEmpty}  = "Поле Пароль не заполнено.";
$lng->{errEmlEmpty}  = "Поле Email не заполнено.";
$lng->{errEmlInval}  = "Адрес Email неверен.";
$lng->{errWordEmpty} = "Поле Ключевые слова не заполнено.";
$lng->{errNamSize}   = "Имя участника слишком коротко или длинно.";
$lng->{errPwdSize}   = "Пароль слишком короток или длинен.";
$lng->{errEmlSize}   = "Адрес Email слишком короток или длинен.";
$lng->{errNamChar}   = "Имя участника содержит недопустимые символы.";
$lng->{errNamNFKC}   = "Имя участника должно быть в 'Unicode Normalization Form KC' по причинам, связанным с безопасностью. Проще говоря, запрещено использование необычных символов.";
$lng->{errPwdChar}   = "Пароль содержит недопустимые символы.";
$lng->{errPwdWrong}  = "Пароль неверен.";
$lng->{errReg}       = "Вы должны выполнить Вход на форум, перед тем как использовать эту функцию.";
$lng->{errBlocked}   = "Доступ запрещен";
$lng->{errBannedT}   = "Ваши права были ограничены. Причина:";
$lng->{errBannedT2}  = "Продолжительность: ";
$lng->{errBannedT3}  = "дней.";
$lng->{errBlockedT}  = "Ваш IP адрес внесен в черный список форума.";
$lng->{errBlockEmlT} = "Домен вашего email адреса внесен в черный список форума.";
$lng->{errAuthz}     = "Доступ закрыт";
$lng->{errAdmin}     = "У вас нет необходимых для такого действия прав администратора.";
$lng->{errCheat}     = "Забавная попытка.";
$lng->{errSubLen}    = "Макс. длина Темы превышена.";
$lng->{errBdyLen}    = "Макс. размер Текста превышен.";
$lng->{errReadOnly}  = "Только администраторы, модераторы и привилегированные участники могут писать в этом разделе.";
$lng->{errModOwnPst} = "Вы не можете голосовать за/против собственных сообщений.";
$lng->{errTpcLocked} = "Тема закрыта, Вы не можете отправлять, исправлять сообщения и голосовать.";
$lng->{errSubNoText} = "Тема не содержит какой-либо настоящий текст.";
$lng->{errNamGone}   = "Это имя уже используется другим участником.";
$lng->{errEmlGone}   = "Этот email уже используется другим участником. Допустимо иметь только одного участника на один адрес.";
$lng->{errPwdDiffer} = "Пароли отличаются друг от друга.";
$lng->{errEmlDiffer} = "Адреса Email отличаются друг от друга.";
$lng->{errDupe}      = "Это сообщение уже было отправлено.";
$lng->{errAttName}   = "Файл или имя файла не определен.";
$lng->{errAttSize}   = "Загрузка сорвалась, или превышен максимально допустимый размер файла для загрузки.";
$lng->{errAttDisab}  = "Загрузка файлов не разрешена.";
$lng->{errPromoTpc}  = "Это сообщение - базовое для всей темы.";
$lng->{errRollback}  = "Действие не произведено.";
$lng->{errPstEdtTme} = "Сообщения могут редактироваться в течение ограниченного времени с момента первоначальной публикации. Этот период времени уже истек.";
$lng->{errDontEmail} = "Отправка письма вашему участнику автоматически блокирована. Типичные причины блокировки: неверный адрес email, неисправный почтовый ящик или включенный автоответчик.";
$lng->{errEditAppr}  = "Вы не можете исправлять сообщения, которые уже были одобрены модератором.";
$lng->{errAdmUsrReg} = "На этом форуме участник может быть зарегистрирован только администратором.";
$lng->{errTdoDupe}   = "Это сообщение уже в списке сохраненных.";
$lng->{errRepOwn}    = "Нет смысла доносить на собственные сообщения.";
$lng->{errRepDupe}   = "Вы уже донесли на это сообщение.";
$lng->{errRepReason} = "Поле Причина не заполнено.";
$lng->{errSrcAuth}   = "Запрос на аутентификацию источника не выполнен. Либо кто-то разыграл Вас, заставив делать то, что Вы не собирались, либо значения аутентификации обновлялись. В последнем случае просто повторите то, что Вы собирались сделать.";
$lng->{errPolExist}  = "Сообщение уже содержит голосование.";
$lng->{errPolOneOpt} = "Анкета для голосования требует как минимум двух вариантов ответа.";
$lng->{errPolNoDel}  = "Только незаполненные никем анкеты могут быть удалены.";
$lng->{errPolNoOpt}  = "Свойство не выбрано.";
$lng->{errPolNotFnd} = "Голосование не существует.";
$lng->{errPolLocked} = "Голосование закрыто.";
$lng->{errPolOpNFnd} = "Свойство голосования не существует.";
$lng->{errPolVotedP} = "Вы уже голосовали по этому вопросу.";
$lng->{errFeatDisbl} = "Эта возможность не разрешена.";
$lng->{errAvaSizeEx} = "Превышен максимальный размер файла.";
$lng->{errAvaDimens} = "Изображение должно иметь параметры ширины и высоты.";
$lng->{errAvaFmtUns} = "Формат файла не поддерживается или неверен.";
$lng->{errAvaNoAnim} = "Анимированные изображения не разрешены.";
$lng->{errRepostTim} = "Флуд-контроль активирован. Вы должны подождать %s секунд перед тем как сможете снова отправить сообщение.";
$lng->{errCrnEmuBsy} = "Форум в настоящее время занят автоматическими профилактическими операциями. Пожалуйста, зайдите попозже.";
$lng->{errForumLock} = "Форум сейчас заблокирован администрацией. Пожалуйста, приходите завтра.";
$lng->{errMinRegTim} = "Вы должны быть зарегистрированы в течение как минимум %s часов перед тем как сможете использовать эту возможность.";
$lng->{errSsnTmeout} = "Время сессии в форуме истекло или неверно. Пожалуйста, выполните вход снова, если это нужно.";
$lng->{errDbHidden}  = "Произошла и была зафиксирована в журнале ошибка базы данных.";
$lng->{errCptTmeOut} = "Время действия картинки с искаженными буквами заканчивается, у Вас есть [[seconds]] секунд чтобы заполнить форму.";
$lng->{errCptWrong}  = "Буквы с картинки введены неправильно. Попробуйте снова.";
$lng->{errCptFail}   = "Вы не прошли спамбот-тест.";

#------------------------------------------------------------------------------
# Help

$lng->{help} = "
<h3>Форум</h3>

<p>Форум представляет собой самостоятельную часть сайта, предназначенную для общения его посетителей. Форум обычно содержит несколько разделов.
Следует входить в форум по ссылке, которая заканчивается на forum.pl (а не на forum_show.pl) чтобы уведомлять форум о начале новой сессии. Иначе форум не сможет определить, какие сообщения отмечать как старые, а какие - как новые.</p>

<h3>Участник</h3>

<p>Участник - это кто-либо, зарегистрированный на форуме. Для чтения регистрации обычно не требуется, но только зарегистрированные участники могут различать старые и новые, а также прочитанные и непрочитанные сообщения. Участники могут получить статус привилегированных в определенных разделах, что позволит им читать закрытые разделы и писать в разделах, предназначенных только для чтения всеми участниками.</p>

<h3>Раздел</h3>

<p>Раздел содержит темы, которые, в свою очередь, содержат сообщения. Разделы могут быть сделаны видимыми только для зарегистрированных участников или для администраторов, редакторов и привилегированных участников. Разделы могут функционировать в анонимном режиме, это означает, что ID участников не будут связаны с сообщениями (это не дает полной гарантии анонимности от администрации), а также настройки разделов могут позволять незарегистрированным анонимным гостям добавлять свои сообщения. Разделы с извещениями могут иметь статус Только для чтения, так что писать сообщения в них смогут только администраторы, редакторы и привилегированные участники, или статус Только ответы, это обозначает, что только администраторы, редакторы и привилегированные участники могут начинать новые темы, но каждый может ответить. Еще одна настройка раздела - это редактирование. Если эта возможность активирована, новые сообщения будут невидимы для обычных участников до тех пор пока администратор или редактор одобрит их. Участники могут подписаться на раздел, что значит: они будут получать новые сообщения за день в этом разделе в одном ежедневном письме.</p>

<h3>Тема</h3>

<p>Тема, иначе известная как топик или тред, содержит все сообщения по определенной тематике, которая должна быть обозначена в заголовке темы. В разделе может есть функция чистки, которая определяет, спустя сколько дней темы удаляются или блокируются после того, как было добавлено последнее сообщение в эту тему. Администраторы и редакторы могут закрыть тему и вручную, так что в нее нельзя будет добавить новое сообщение.</p>

<h3>Сообщение</h3>

<p>Сообщение - это отдельное публичное высказывание участника. Это может быть либо базовое сообщение, которое начинает новую тему, или ответ в существующей теме. Сообщения могут быть отредактированы либо удалены, эти функции могут быть ограничены определенными временными рамками. Сообщения могут быть добавлены в личный список сохраненных и на них может быть составлен донос администраторам и редакторам в случае нарушения правил.</p>

<h3>Приватное сообщение</h3>

<p>В дополнение к публичным сообщениям, на форуме могут быть разрешены приватные сообщения. Зарегистрированные участники могут посылать друг другу эти сообщения, не зная адрес email получателя.</p>

<h3>Администратор</h3>

<p>Администратор может контролировать и редактировать любые части форума. Форум может иметь несколько администраторов.</p>

<h3>Редактор</h3>

<p>Власть редактора ограничена разделами, которые он редактирует. Редактор может менять, удалять и одобрять сообщения от обычных участников, блокировать и удалять темы, добавлять и удалять привилегированных участников раздела и проверять список доносов. В разделе может быть несколько редакторов.</p>

<h3>Голосования</h3>

<p>Автор темы может добавить к ней голосование, если эта возможность разрешена. Каждая анкета для голосования может содержать до 20 вариантов ответа. Зарегистрированные участники могут отдать один голос за один вариант одного голосования. Анкету для голосования нельзя менять после добавления, и она может быть удалена только в том случае, если никто еще не проголосовал.</p>

<h3>Иконки</h3>

<table>
<tr><td>
<img src='[[dataPath]]/post_nu.png' alt='N/U'/>
<img src='[[dataPath]]/topic_nu.png' alt='N/U'/>
<img src='[[dataPath]]/board_nu.png' alt='N/U'/>
</td><td>
Желтыми иконками обозначаются темы с новыми сообщениями или разделы с новыми сообщениями.
В этом форуме, 'новым' считается сообщение, добавленное со времени Вашего последнего визита на форум. Даже если Вы уже прочитали его, оно по прежнему будет новым, и только после следующего посещения форума будет помечено как старое.
</td></tr>
<tr><td>
<img src='[[dataPath]]/post_or.png' alt='O/R'/>
<img src='[[dataPath]]/topic_or.png' alt='O/R'/>
<img src='[[dataPath]]/board_or.png' alt='O/R'/>
</td><td>
Галочки означают, что все сообщения темы или раздела были прочитаны. Сообщения отмечаются как прочитанные после захода в тему, где они находятся или если они старше, чем определенное число дней. Поскольку новое/старое и непрочитанное/прочтенное являются независимыми маркерами в этом форуме, сообщения могут быть как новыми и прочитанными так и старыми прочитанными и непрочитанными.
</td></tr>
<tr><td>
<img src='[[dataPath]]/post_i.png' alt='I'/>
<img src='[[dataPath]]/topic_i.png' alt='I'/>
</td><td>
Иконками с пунктирными краями обозначаются темы/сообщения, невидимые для других участников, потому что они ожидают одобрения администратором или редактором.
</td></tr>
<tr><td>
<img src='[[dataPath]]/topic_l.png' alt='L'/>
</td><td>
Иконка замка обозначает тему, которая была закрыта по какой-либо причине, и в которой нельзя оставлять сообщения (кроме администраторов и редакторов).
</td></tr>
</table>

<h3>Тэги форматирования текста</h3>

<p>По соображениям безопасности, mwForum позволяет использовать только собственный набор тэгов для форматирования текста, без тэгов 
HTML. Допустимые тэги для форматирования:</p>

<table>
<tr><td>[b]текст[/b]</td>
<td>выводит текст <b>жирно</b></td></tr>
<tr><td>[i]текст[/i]</td>
<td>выводит текст <i>курсивом</i></td></tr>
<tr><td>[tt]текст[/tt]</td>
<td>выводит текст <tt>непропорционально</tt></td></tr>
<tr><td>[img]ссылка[/img]</td>
<td>вставляет изображение, лежащее на другом сервере (если эта возможность разрешена)</td></tr>
<tr><td>[url]ссылка[/url]</td>
<td>ссылка на сайт</td></tr>
<tr><td>[url=address]текст[/url]</td>
<td>текст, ссылающийся на определенный сайт</td></tr>
</table>

<h3>Смайлики</h3>

<p>Следующие символы отображаются как изображения (если эта возможность включена): :-) ;-) :-( :-o</p>

";

#------------------------------------------------------------------------------
# Часто задаваемые вопросы

$lng->{faq} = "

<h3>Я забыл свой пароль, вы можете выслать его мне?</h3>

<p>Нет, пароли в исходном виде нигде не хранятся по соображениям безопасности. Но на странице Входа в форум Вы можете запросить email содержащий временную ссылку для входа (действует ограниченный период времени). После использования этой ссылки для входа, Вы сможете изменить свой пароль.</p>

<h3>Зачем эта сложная регистрация с получением пароля через ящик email?</h3>

<p>На этом форуме есть несколько модулей, которые могут посылать Вам email, например уведомление об ответе и подписка на раздел. Форум требует, чтобы Вы использовали верный адрес email и вышлет пароль только на этот адрес, чтобы проверить его подлинность. Это необходимо, поскольку иначе многие люди будут использовать несуществующие или неработающие адреса а затем обязательно начнут пытаться использовать модули, требующие связи с реальным ящиком email, что приведет к появлению тысяч сообщений администраторам о не доставленных письмах. Этот процесс регистрации, кроме того, может защитить форум от размещения спамерских тем и от использования одним человеком массы фиктивных имен участников форума.</p>

<h3>Должен ли я использовать функцию Выход с форума?</h3>

<p>Этой функцией нужно пользоваться только в том случае, если за вашим компьютером может оказаться человек, которому Вы не доверяете. mwForum хранит ваш ID участника и пароль в файлах cookie на вашем компьютере, и эти данные удаляются, когда вы нажимаете Выход. Вы можете также использовать функцию 'Ограничить период работы в форуме временем сессии браузера' в своих настройках участника для автоматического выхода в тот момент, когда Вы закрываете последнее окно браузера.</p>

<h3>Как присоединять к сообщениям изображения и другие файлы?</h3>

<p>Если присоединение файлов разрешено в этом форуме и в конкретном разделе Вы можете использовать эту функцию, сначала отправив сообщение без присоединенного файла, а затем нажав кнопку Файл под сообщением, чтобы перейти к закачке файла. Отправка сообщения и закачка файла разделены таким образом потому, что закачка может пройти неудачно по разным причинам, и очевидно, что Вы не захотите из-за каких-то проблем потерять текст, который перед этим набирали.</p>

";

# Load local string overrides
do 'MwfRussianLocal.pm';

#------------------------------------------------------------------------------
# Return OK
1;
