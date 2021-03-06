$PBExportHeader$nvo_notifications.sru
forward
global type nvo_notifications from timing
end type
type rect from structure within nvo_notifications
end type
type appbardata from structure within nvo_notifications
end type
end forward

type rect from structure
	long		Left
	long		Top
	long		Right
	long		Bottom
end type

type appbardata from structure
	long		cbSize
	long		hwnd
	long		uCallbackMessage
	long		uEdge
	rect		rc
	long		lparam
end type

global type nvo_notifications from timing
end type
global nvo_notifications nvo_notifications

type prototypes
Function Long SHAppBarMessage (Long dwMessage, Ref APPBARDATA pdata) Library "shell32.dll" Alias For "SHAppBarMessage;Ansi"

end prototypes
type variables

Private:
w_notifications iw // the window to glide in

Long il_Margin = 100 // The margin of the (side of the ) glide-in window with the screen border

Integer ii_mode // is the window moving in or out

/* RESTARTING*/
String 		is_restartmsg = ""
Integer 	ii_restartSpeed = 10
Boolean 	ib_Restart = False

/* moving out*/
Long il_outfinalX // the final X pos of the window
Long il_outfinalY // The final Y pos of the window
Integer ii_direction // the direction to move into

/* moving in */
Long il_infinalx // X POS WHEN HIDING THE WINDOW
Long il_infinaly // Y POS WHEN HIDING THE WINDOW

Public:
Integer ii_Stepsize = 10

Constant Integer MOVEDOWN 	 = 1
Constant Integer MOVELEFT 	 = 2
Constant Integer MOVEUP 	 = 3
Constant Integer MOVERIGHT = 4

Constant Integer VERYSLOW 	 = 5
Constant Integer SLOW 	 = 10
Constant Integer NORMAL 	 = 20
Constant Integer FAST 		 = 30
Constant Integer VERYFAST 	 = 40

Constant Integer MODEIN = 1
Constant Integer MODEOUT = 2

Constant Integer Top = 1
Constant Integer Right = 2
Constant Integer BOTTOM = 3
Constant Integer Left = 4

end variables

forward prototypes
public function integer of_glideout (string as_msg, integer ai_speed)
protected function integer of_stop ()
public function integer of_glidein ()
public function integer of_gettaskbardimensions (ref long al_height, ref long al_width, ref long al_xpos, ref long al_ypos)
public function integer of_getlocation ()
end prototypes

public function integer of_glideout (string as_msg, integer ai_speed);//====================================================================
// Function: nvo_notifications.of_glideout()
//--------------------------------------------------------------------
// Description: Glide in the window
//--------------------------------------------------------------------
// Arguments:
// 	string 	as_msg  	 the message to display
// 	integer	ai_speed	 The speed the window should pop out
//--------------------------------------------------------------------
// Returns:  integer, -1 = failure, 0  = no action, 1  = success 
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/05/28
//--------------------------------------------------------------------
// Usage: nvo_notifications.of_glideout ( string as_msg, integer ai_speed )
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long 			ll_TaskBarX				/* The X Pos of the taskbar */
Long			ll_TaskBarY				/* The Y pos of the Taskbar */
Long			ll_TaskBarHeight		/* The height of the TaskBar */
Long			ll_TaskBarWidth		/* The Width of the Taskbar */
Long			ll_ScreenWidth			/* The screen resolution */
Long			ll_ScreenHeight		/* The screen resolution */
Environment lenv

/* initialize */
ib_Restart = False
If ai_speed <= 0 Then
	/* FAILURE */
	MessageBox( 'Error', ClassName() + '.of_GlideOut()~n~nInvalid parameter. Speed cannot be less than or equal to zero.' )
	Return -1
End If

/* Get the screen resolution */
GetEnvironment( lenv )
ll_ScreenWidth  = PixelsToUnits( lenv.ScreenWidth,  XPixelsToUnits! )
ll_ScreenHeight = PixelsToUnits( lenv.ScreenHeight, YPixelsToUnits! )

/* Get the dimensions of the taskbar */
This.of_GetTaskBarDimensions( ll_TaskBarHeight, ll_TaskBarWidth, ll_TaskBarX, ll_TaskBarY )

/* close the window if it is already open */
If IsValid( iw ) Then
	/* store the message and speed of the next message until the current message hides*/
	is_RestartMsg 		 = as_msg
	ii_RestartSpeed 	 = ai_speed
	ib_Restart 			 = True /* MARK THAT ONCE THE CURRENT WINDOW IS HIDDEN, A NEW ONE SHOULD POP-UP */
	This.of_GlideIn( )
	/* WAIT UNTIL THE WINDOW HAS MOVED DOWN */
	Return 0
End If

This.ii_mode = MODEOUT  /* GLIDE OUT THE MESSAGE */
Open( iw )
iw.of_SetText( as_msg )
iw.Hide( )

/* Determine the location where to open the window */
Choose Case This.of_GetLocation()
	Case This.Top
		il_InFinalY = 0 - ( iw.Height - ll_TaskBarHeight )
		il_InFinalX = ll_ScreenWidth - iw.Width - il_margin
		ii_Direction = MOVEDOWN
	Case This.Right
		il_InFinalY = ll_ScreenHeight - iw.Height - il_margin
		il_InFinalX = ll_ScreenWidth - ll_TaskBarWidth
		ii_Direction = MOVELEFT
	Case This.BOTTOM
		il_InFinalX = ll_ScreenWidth - iw.Width - il_margin
		il_InFinalY = ll_TaskBarY
		ii_Direction = MOVEUP
	Case This.Left
		il_InFinalY = ll_ScreenHeight - iw.Height - il_margin
		il_InFinalX = 0 -( iw.Width - ll_TaskBarWidth )
		ii_Direction = MOVERIGHT
End Choose

ii_StepSize = ai_speed

iw.Show( )
iw.Move( il_InFinalX, il_InFinalY )
/* glide the window out of the taskbar */
Choose Case ii_Direction
	Case MOVEDOWN
		il_outFinalX = il_InFinalX
		il_OutFinalY = il_InFinalY + iw.Height
	Case MOVELEFT
		il_outFinalX = il_InFinalX - iw.Width
		il_OutFinalY = il_InFinalY
	Case MOVEUP
		/* Set the final position */
		il_outFinalX = il_InFinalX
		il_OutFinalY = il_InFinalY - iw.Height
	Case MOVERIGHT
		il_outFinalX = il_InFinalX + iw.Width
		il_OutFinalY = il_InFinalY
End Choose

/* start */
Start( .05 )

/* SUCCESS */
Return 1

end function

protected function integer of_stop ();//====================================================================
// Function: nvo_notifications.of_stop()
//--------------------------------------------------------------------
// Description: The gliding stopped. The window must be fixed
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer, -1 = failure, 0  = no action, 1  = success 
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/05/28
//--------------------------------------------------------------------
// Usage: nvo_notifications.of_stop ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


This.Stop() // Stop the timing

Choose Case ii_Mode
	Case ModeOut
		/* fix window on final position */
		iw.Move( il_outfinalx, il_outfinaly )
	Case ModeIn
		/* close the window */
		If IsValid( iw ) Then Close( iw )
		If ib_Restart Then
			/* POP OUT THE NEXT WINDOW */
			This.of_GlideOut( is_RestartMsg, ii_RestartSpeed )
		End If
End Choose

Return 1

end function

public function integer of_glidein ();//====================================================================
// Function: nvo_notifications.of_glidein()
//--------------------------------------------------------------------
// Description: Hide the current window
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer, -1 = failure, 0  = no action, 1  = success 
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/05/28
//--------------------------------------------------------------------
// Usage: nvo_notifications.of_glidein ( )
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


If Not IsValid( iw ) Then
	/* WINDOW IS NOT OPEN */
	Return 0
End If

ii_mode = MODEIN

/* REVERSE DIRECTION */
Choose Case ii_direction
	Case MOVEDOWN
		ii_direction = MOVEUP
	Case MOVELEFT
		ii_direction = MOVERIGHT
	Case MOVEUP
		ii_direction = MOVEDOWN
	Case MOVERIGHT
		ii_direction = MOVELEFT
End Choose

/* SET THE FINAL POSITION OF THE WINDOW */
il_OutFinalX = il_InFinalX
il_OutFinalY = il_InFinalY

/* start the gliding */
Start( .05 )

/* SUCCESS */
Return 1

end function

public function integer of_gettaskbardimensions (ref long al_height, ref long al_width, ref long al_xpos, ref long al_ypos);//====================================================================
// Function: nvo_notifications.of_gettaskbardimensions()
//--------------------------------------------------------------------
// Description: Calculate the dimensions of the Window's taskbar
//--------------------------------------------------------------------
// Arguments:
// 	ref	long	al_height	 The height of the taskbar in PBUnits
// 	ref	long	al_width 	The width of the taskbar in PBUnits
// 	ref	long	al_xpos  	The Horizontal position of the taskbar in pbunits
// 	ref	long	al_ypos  	The Vertical position of the taskbar in pbunits
//--------------------------------------------------------------------
// Returns:  integer : -1 = failure, 0  = no action , 1  = success 
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/05/28
//--------------------------------------------------------------------
// Usage: nvo_notifications.of_gettaskbardimensions ( ref long al_height, ref long al_width, ref long al_xpos, ref long al_ypos )
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ABM_GETTASKBARPOS = 5
appbardata 					lstr

shappbarmessage( ABM_GETTASKBARPOS, lstr )

al_height = PixelsToUnits( lstr.rc.bottom - lstr.rc.Top , YPixelsToUnits! )
al_Width  = PixelsToUnits( lstr.rc.Right  - lstr.rc.Left, XPixelsToUnits! )
al_xpos	 = PixelsToUnits( lstr.rc.Left, XPixelsToUnits! )
al_ypos	 = PixelsToUnits( lstr.rc.Top,  YPixelsToUnits! )

/* SUCCESS */
Return 1

end function

public function integer of_getlocation ();//====================================================================
// Function: nvo_notifications.of_getlocation()
//--------------------------------------------------------------------
// Description: Get the location of the taskbar
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer INTEGER: nvo_Taskbar.TOP, nvo_Taskbar.RIGHT, nvo_Taskbar.BOTTOM, nvo_Taskbar.LEFT
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/05/28
//--------------------------------------------------------------------
// Usage: nvo_notifications.of_getlocation ( )
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


/* GET THE DIMENSIONS OF THE TASKBAR */
Long ABM_GETTASKBARPOS = 5
appbardata 					lstr
Long							ll_DTWidth // desktop width
Environment					lenv

/* Get the screen resolution */
GetEnvironment( lenv )
ll_DTWidth = lenv.ScreenWidth

/* Get the dimensions of the task bar */
shappbarmessage( ABM_GETTASKBARPOS, lstr )

If lstr.rc.Left < 0 And lstr.rc.Top < 0 Then
	If lstr.rc.Right >= ll_DTWidth Then
		/* TASK BAR IS AT THE TOP OF THE DESKTOP */
		Return This.Top
	Else
		/* TASK BAR IS ON THE LEFT OF THE DESKTOP */
		Return This.Left
	End If
ElseIf lstr.rc.Left < 0 Then
	/* TASK BAR IS AT BOTTOM OF THE DESKTOP */
	Return This.BOTTOM
Else
	/* TASK BAR IS ON THE RIGHT  OF THE DESKTOP */
	Return This.Right
End If

Return 1

end function

on nvo_notifications.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_notifications.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;/*===============================================================================

 Description		: 	move the window
			
 Access       	:	public

 Arguments		:	None

 Returns			: 		-1 = failure
							0  = no action
							1  = success 

 Note			:


Original code is free of copyright. Downloaded from http://www.pbinfo.be

===============================================================================
 Build		Tricode		Description of change		Date
 -----		-------		---------------------		----
  1.0		  	AOO		Initial version			08/04/2003
===============================================================================*/


CHOOSE CASE This.ii_direction
	CASE MOVEDOWN
		iw.Move( iw.x, iw.y + ii_StepSize )
		IF iw.Y >= il_outFinalY THEN
			/* The end is reached */
			This.of_Stop( )
		END IF
	CASE MOVELEFT
		iw.Move( iw.x - ii_StepSize, iw.y )
		IF iw.x <= il_outFinalX THEN
			/* The end is reached */
			This.of_Stop( )
		END IF
	CASE MOVEUP
		iw.Move( iw.x, iw.y - ii_stepsize )
		IF iw.y <= il_outfinaly THEN
			/* The end is reached */
			This.of_Stop( )
		END IF
	CASE MOVERIGHT
		iw.Move( iw.x + ii_StepSize, iw.y )
		IF iw.x >= il_outFinalX THEN
			/* The end is reached */
			This.of_Stop( )
		END IF
END CHOOSE

/* SUCCESS */
RETURN


end event

event destructor;/*===============================================================================
 

 Description		: 	Close the window
			
 Access       		:	public

 Arguments			:	None

 Returns				: 		-1 = failure
							0  = no action
							1  = success 

 Note					:

===============================================================================
 Build		Tricode		Description of change		Date
 -----		-------		---------------------		----
  1.0		  	AOO		Initial version			14/04/2003
===============================================================================*/

IF IsValid( iw ) THEN Close( iw )
end event

