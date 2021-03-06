Imports System
Imports EnvDTE
Imports EnvDTE80
Imports EnvDTE90
Imports EnvDTE90a
Imports EnvDTE100
Imports System.Diagnostics

Public Module Convenience
    Sub ConvertAutomaticPropertyToGridViewColumn()
        DTE.ActiveDocument.Selection.EndOfLine()
        DTE.ActiveDocument.Selection.StartOfLine(vsStartOfLineOptions.vsStartOfLineOptionsFirstText, True)
        DTE.ExecuteCommand("Edit.CommentSelection")
        DTE.ActiveDocument.Selection.StartOfLine(vsStartOfLineOptions.vsStartOfLineOptionsFirstText)
        DTE.ActiveDocument.Selection.WordRight()
        DTE.ActiveDocument.Selection.Text = "  "
        DTE.ActiveDocument.Selection.CharLeft()
        DTE.ActiveDocument.Selection.Text = "<GridViewColumn Header="""
        DTE.ActiveDocument.Selection.WordRight(True, 3)
        DTE.ActiveDocument.Selection.Delete()
        DTE.ActiveDocument.Selection.WordRight(True)
        DTE.ActiveDocument.Selection.CharLeft(True)
        DTE.ActiveDocument.Selection.Copy()
        DTE.ActiveDocument.Selection.CharRight()
        DTE.ActiveDocument.Selection.Text = """ DisplayMemberBinding=""{Binding "
        DTE.ActiveDocument.Selection.Paste()
        DTE.ActiveDocument.Selection.Text = "}"" />"
        DTE.ActiveDocument.Selection.EndOfLine(True)
        DTE.ActiveDocument.Selection.Delete()
        DTE.ActiveDocument.Selection.StartOfLine(vsStartOfLineOptions.vsStartOfLineOptionsFirstText)
        DTE.ActiveDocument.Selection.WordRight(True)
        DTE.ActiveDocument.Selection.Delete()
        DTE.ActiveDocument.Selection.LineDown(False, 2)
    End Sub
    Sub FSharpSpecCopyCodeIntoSpecName()
        DTE.ActiveDocument.Selection.StartOfLine(vsStartOfLineOptions.vsStartOfLineOptionsFirstText)
        DTE.ActiveDocument.Selection.WordRight(False, 2)
        DTE.ActiveDocument.Selection.EndOfLine(True)
        DTE.ActiveDocument.Selection.Copy()
        DTE.ActiveDocument.Selection.StartOfLine(vsStartOfLineOptions.vsStartOfLineOptionsFirstText)
        DTE.ActiveDocument.Selection.WordRight()
        DTE.ActiveDocument.Selection.CharRight()
        DTE.ActiveDocument.Selection.Paste()
        DTE.ActiveDocument.Selection.EndOfLine()
    End Sub
End Module
