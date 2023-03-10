$PBExportHeader$toastnotification.sra
$PBExportComments$Generated Application Object
forward
global type toastnotification from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

end variables

global type toastnotification from application
string appname = "toastnotification"
end type
global toastnotification toastnotification

type prototypes

end prototypes

on toastnotification.create
appname="toastnotification"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on toastnotification.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;Open(w_main)
end event

