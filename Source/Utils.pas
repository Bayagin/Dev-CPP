{
    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

unit Utils;

interface

uses
  Windows, Classes, Sysutils, Dateutils, Forms, ShellAPI, Dialogs, SynEdit, SynEditHighlighter,
  Menus, Registry, Controls, ComCtrls, Messages, Graphics;

type
  { File ID types }
  TExUnitType = (
    utcSrc, // c source file (.c)
    utcppSrc, // c++ source file (.cpp)
    utcHead, // c header (.h)
    utcppHead, // c++ header (.hpp)
    utresHead, // resouce header (.rh)
    utresComp, // resource compiled (.res)
    utresSrc, // resource source (.rc)
    utPrj, // project file (.dev)
    utMakefile, // makefile (.win)
    utOther // any others
    );

  TFileEncodingType = (
    etUTF8,   // utf8 encoding
    etAscii,  // all chars are ascii encoding (0-127)
    etOther  // other encoding such as GB2312
  );

  TFilterSet = (ftOpen, ftPrj, ftSrc, ftAll);

  TLineOutputFunc = procedure(const Line: String) of object;
  TCheckAbortFunc = procedure(var AbortThread: boolean) of object;

  TThemeColor = packed record
    Foreground:TColor;
    Background:TColor;
  end;

procedure FilesFromWildcard(Directory: String; const Mask: String; Files: TStringList; Subdirs, ShowDirs,
  Multitasking: Boolean);

function ExecuteFile(const FileName, Params, DefaultDir: String; ShowCmd: Integer): THandle;
function RunAndGetOutput(const Cmd, WorkDir: String; LineOutputFunc: TLineOutputFunc; CheckAbortFunc:
  TCheckAbortFunc; ShowReturnValue: Boolean = True;pEnvironment:PChar=nil): String;

function GetShortName(const FileName: String): String;

function FormatList(const sl: TStrings; formatstr: String): String;
function IncludeQuoteIfSpaces(const s: String): String;
function IncludeQuoteIfNeeded(const s: String): String;

function ValidateFile(const FileName: String; const WorkPath: String; const CheckDirs: boolean = FALSE):
  String;

function BuildFilter(const Filters: array of String): String;

function CodeInstoStr(const s: String): String;
function StrtoCodeIns(const s: String): String;

procedure StrtoAttr(var Attr: TSynHighlighterAttributes; const Value: String);
function AttrtoStr(Attr: TSynHighlighterAttributes): String;

procedure StrToThemeColor(var tc: TThemeColor; const value: String);
function ThemeColortoStr(tc: TThemeColor): String;

function GetFileTyp(const FileName: String): TExUnitType;

procedure SetPath(const Add: String; UseOriginal: boolean = TRUE);
function ExpandFileto(const FileName, BasePath: String): String;
function FileSamePath(const FileName, TestPath: String): boolean;
procedure CloneMenu(FromMenu, ToMenu: TMenuItem);

function FindComplement(const s: String; fromtoken, totoken: char; var curpos: integer; increment: integer):
  boolean;

function FPos(const SubStr, S: String; start: integer): integer;

function RPos(const SubStr, S: String): integer; overload;
function RPos(const SubStr, S: String; start: integer): integer; overload;

function GenMakePath1(const FileName: String): String;
function GenMakePath2(const FileName: String): String;
function GenMakePath(const FileName: String; EscapeSpaces, EncloseInQuotes: Boolean): String; overload;

function GetRealPath(const BrokenFileName: String; const Directory: String = ''): String;

function GetVersionString(const FileName: String): String;

function GetAssociatedProgram(const Extension: String; var Filename, Description: String): boolean;

function IsNumeric(const s: String): boolean;

function CountChar(const s: String; c: Char): integer;

function CharToValue(c: char): integer;

procedure OpenHelpFile(const HelpFileName: String);

function ProgramHasConsole(const Path: String): boolean;

function GetBuildTime(const Path: String): String;

function IsKeyDown(key: integer): boolean;

function GetPrettyLine(hwnd: TListView; i: integer = -1): String; // removes #10 subitem delimiters

function IsWindows64: boolean;

function GetFileSize(const FileName: String): integer;

function FormatFileSize(Size: integer): String;

function ShortenLogOutput(const Input: String): String;

// These functions are about six times faster than the locale sensitive AnsiX() versions
function StartsStr(const subtext, text: String): boolean;
function StartsText(const subtext, text: String): boolean;

function SameStr(const s1, s2: String): boolean;
function SameText(const s1, s2: String): boolean;

function EndsStr(const subtext, text: String): boolean;
function EndsText(const subtext, text: String): boolean;

function ContainsStr(const text, subtext: String): boolean;
function ContainsText(const text, subtext: String): boolean;

// Same as StringReplace, but only replace first OldPattern (a lot faster)
function ReplaceFirstStr(const S, OldPattern, NewPattern: String): String;
function ReplaceFirstText(const S, OldPattern, NewPattern: String): String;

function ReplaceLastStr(const S, OldPattern, NewPattern: String): String;
function ReplaceLastText(const S, OldPattern, NewPattern: String): String;

// Reverse Pos() function
function LastPos(const SubStr, S: String): integer;

// Native SelectDirectory function that lets you set flags
function NewSelectDirectory(const Caption: string; const Root: WideString; var Directory: string): Boolean;

// Fast implementation of StringReplace which does not use AnsiX (MBCS ready) comparison
function FastStringReplace(const S, OldPattern, NewPattern: String; Flags: TReplaceFlags): String;

// Fast implementation of IndexOf which does not use AnsiX (MBCS ready) comparison
function FastIndexOf(List: TStrings; const S: String): integer; overload;
function FastIndexOf(List: TStringlist; const S: String): integer; overload;

// Convert local encoding string to/from utf8 string 
function UTF8ToAnsi(s:String):String;
function AnsiToUTF8(s:String):String;

function GetSystemCharsetName():String;

function GetLanguageFileName():String;

function GetFileEncodingType(s:String):TFileEncodingType;

// Dialogs with the same font setting as mainform
function ShowInputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
function ShowInputBox(const Caption, Prompt, Default : string): String;
function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string): Boolean;

function IsIdentifier(const s:string):boolean;

procedure AppendToFile(filename:String; text:String);overload;
procedure AppendToFile(filename:String; strings:TStrings);overload;
procedure LogError(source:String; msg:String);

function CreateDirRecursive(const Dir: string): Boolean;

implementation

uses
  devcfg, version, StrUtils, MultiLangSupport, main, editor, ShlObj, ActiveX, codepage,
  FileCtrl;

function FastStringReplace(const S, OldPattern, NewPattern: String; Flags: TReplaceFlags): String;
var
  SearchStr, Patt, NewStr: String;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then begin
    SearchStr := UpperCase(S);
    Patt := UpperCase(OldPattern);
  end else begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do begin
    Offset := Pos(Patt, SearchStr);
    if Offset = 0 then begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function FastIndexOf(List: TStrings; const S: String): integer;
begin
  with List do begin
    for Result := 0 to Count - 1 do
      if CompareText(List[Result], S) = 0 then
        Exit;
    Result := -1;
  end;
end;

function FastIndexOf(List: TStringlist; const S: String): integer;
begin
  with List do begin
    if not List.Sorted then
      Result := FastIndexOf(TStrings(List), S)
    else if not Find(S, Result) then
      Result := -1;
  end;
end;

function IsKeyDown(key: integer): boolean;
begin
  result := (GetKeyState(key) < 0);
end;

function IsWindows64: boolean;
var
  buffer: array[0..1023] of char;
begin
  // IsWow64Process not available in Delphi 7, so using this instead
  GetEnvironmentVariable('PROGRAMFILES', buffer, 1024);
  result := EndsStr(' (x86)', String(buffer));
end;

function CharToValue(c: char): integer;
begin
  if c in ['a'..'z'] then
    result := integer(c) - integer('a') + 2
  else if (StrToIntDef(c, 0) = 1) then
    result := 1
  else
    result := 0;
end;

function GetPrettyLine(hwnd: TListView; i: integer): String;
begin
  if (i = -1) then begin // selection
    if hwnd.ItemIndex <> -1 then
      result := GetPrettyLine(hwnd, hwnd.ItemIndex)
    else
      result := '';
  end else begin
    result := hwnd.Items[i].Caption + #13#10 + hwnd.Items[i].SubItems.Text; // CRLF separated columns
    result := Trim(StringReplace(result, #13#10, #9, [rfReplaceAll]));
  end;
end;

function StartsStr(const subtext, text: String): boolean;
begin
  Result := SameStr(subtext, Copy(text, 1, Length(subtext)));
end;

function StartsText(const subtext, text: String): boolean;
begin
  Result := SameText(subtext, Copy(text, 1, Length(subtext)));
end;

function SameStr(const s1, s2: String): boolean;
begin
  Result := (CompareStr(s1, s2) = 0);
end;

function SameText(const s1, s2: String): boolean;
begin
  Result := (CompareText(s1, s2) = 0);
end;

function EndsStr(const subtext, text: String): boolean;
var
  SubTextLocation: Integer;
begin
  SubTextLocation := Length(text) - Length(subtext) + 1;
  if (SubTextLocation > 0) and (subtext <> '') then
    Result := StrComp(Pointer(subtext), Pointer(@text[SubTextLocation])) = 0
  else
    Result := False;
end;

function EndsText(const subtext, text: String): boolean;
var
  SubTextLocation: Integer;
begin
  SubTextLocation := Length(text) - Length(subtext) + 1;
  if (SubTextLocation > 0) and (subtext <> '') then
    Result := StrIComp(Pointer(subtext), Pointer(@text[SubTextLocation])) = 0
  else
    Result := False;
end;

function ContainsStr(const text, subtext: String): boolean;
begin
  Result := Pos(subtext, text) > 0;
end;

function ContainsText(const text, subtext: String): boolean;
begin
  Result := Pos(UpperCase(subtext), UpperCase(text)) > 0;
end;

function ReplaceFirstStr(const S, OldPattern, NewPattern: String): String;
var
  Offset: Integer;
begin

  Offset := Pos(OldPattern, S);
  if Offset = 0 then begin
    Result := S;
  end else begin

    // Copy the preceding stuff, append the new part, append old stuff after old pattern
    Result := Copy(S, 1, Offset - 1) + NewPattern + Copy(S, Offset + Length(OldPattern), MaxInt);
  end;
end;

function ReplaceFirstText(const S, OldPattern, NewPattern: String): String;
var
  Offset: Integer;
  UpperS, UpperOldPattern: string;
begin
  UpperS := UpperCase(S);
  UpperOldPattern := UpperCase(OldPattern);

  Offset := Pos(UpperOldPattern, UpperS);
  if Offset = 0 then begin
    Result := S;
  end else begin

    // Copy the preceding stuff, append the new part, append old stuff after old pattern
    Result := Copy(S, 1, Offset - 1) + NewPattern + Copy(S, Offset + Length(UpperOldPattern), MaxInt);
  end;
end;

function ReplaceLastStr(const S, OldPattern, NewPattern: String): String;
var
  Offset: Integer;
begin

  Offset := RPos(OldPattern, S);
  if Offset = 0 then begin
    Result := S;
  end else begin

    // Copy the preceding stuff, append the new part, append old stuff after old pattern
    Result := Copy(S, 1, Offset - 1) + NewPattern + Copy(S, Offset + Length(OldPattern), MaxInt);
  end;
end;

function ReplaceLastText(const S, OldPattern, NewPattern: String): String;
var
  Offset: Integer;
  UpperS, UpperOldPattern: string;
begin
  UpperS := UpperCase(S);
  UpperOldPattern := UpperCase(OldPattern);

  Offset := RPos(UpperOldPattern, UpperS);
  if Offset = 0 then begin
    Result := S;
  end else begin

    // Copy the preceding stuff, append the new part, append old stuff after old pattern
    Result := Copy(S, 1, Offset - 1) + NewPattern + Copy(S, Offset + Length(UpperOldPattern), MaxInt);
  end;
end;

function LastPos(const SubStr, s: String): integer;
begin
  result := Pos(ReverseString(SubStr), ReverseString(S));
  if result <> 0 then
    result := ((Length(S) - Length(SubStr)) + 1) - result + 1;
end;

function ProgramHasConsole(const path: String): boolean;
var
  handle: Cardinal;
  bytesread: DWORD;
  signature: DWORD;
  dos_header: _IMAGE_DOS_HEADER;
  pe_header: _IMAGE_FILE_HEADER;
  opt_header: _IMAGE_OPTIONAL_HEADER;
begin
  handle := CreateFile(pChar(path), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if handle <> INVALID_HANDLE_VALUE then begin
    ReadFile(Handle, dos_header, sizeof(dos_header), bytesread, nil);
    SetFilePointer(Handle, dos_header._lfanew, nil, 0);
    ReadFile(Handle, signature, sizeof(signature), bytesread, nil);
    ReadFile(Handle, pe_header, sizeof(pe_header), bytesread, nil);
    ReadFile(Handle, opt_header, sizeof(opt_header), bytesread, nil);

    Result := (opt_header.Subsystem = IMAGE_SUBSYSTEM_WINDOWS_CUI);
  end else
    Result := false;

  CloseHandle(handle);
end;

function GetBuildTime(const Path: String): String;
var
  dateinteger: integer;
  datedouble: TDateTime;
  //	handle : Cardinal;
  //	bytesread : DWORD;
  //	signature : DWORD;
  //	dos_header : _IMAGE_DOS_HEADER;
  //	pe_header  : _IMAGE_FILE_HEADER;
begin
  dateinteger := FileAge(path);
  datedouble := FileDateToDateTime(dateinteger);

  //	handle := CreateFile(pChar(path),GENERIC_READ,FILE_SHARE_READ,nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
  //	if handle <> INVALID_HANDLE_VALUE then begin
  //		ReadFile(Handle, dos_header, sizeof(dos_header), bytesread, nil);
  //		SetFilePointer(Handle, dos_header._lfanew, nil, 0);
  //		ReadFile(Handle, signature,  sizeof(signature),  bytesread, nil);
  //		ReadFile(Handle, pe_header,  sizeof(pe_header),  bytesread, nil);

  //		Result := UnixToDateTime(pe_header.TimeDateStamp);
  //	end else
  //		Result := 0;

  //	CloseHandle(handle);

  DateTimeToString(Result, 'mmmm d yyyy - hh:nn', datedouble);
end;

procedure OpenHelpFile(const HelpFileName: String);
var
  abshelp: String;
begin // TODO: fix iframe opening problem
  abshelp := ReplaceFirstStr(devDirs.Help, '%path%\', devDirs.Exec) + HelpFileName;
  ShellExecute(GetDesktopWindow(), 'open', pChar(abshelp), nil, nil, SW_SHOWNORMAL);
end;

procedure FilesFromWildcard(Directory: String; const Mask: String; Files: TStringList; Subdirs, ShowDirs,
  Multitasking: Boolean);
var
  SearchRec: TSearchRec;
  Attr, Error: Integer;
begin
  Directory := IncludeTrailingPathDelimiter(Directory);

  // First, find the required file...
  Attr := faAnyFile;
  if ShowDirs = False then
    Attr := Attr - faDirectory;
  Error := FindFirst(Directory + Mask, Attr, SearchRec);
  if (Error = 0) then begin
    while (Error = 0) do begin
      // Found one!
      Files.Add(Directory + SearchRec.Name);
      Error := FindNext(SearchRec);
      if Multitasking then
        Application.ProcessMessages;
    end;
    FindClose(SearchRec);
  end;

  // Then walk through all subdirectories.
  if Subdirs then begin
    Error := FindFirst(Directory + '*.*', faAnyFile, SearchRec);
    if (Error = 0) then begin
      while (Error = 0) do begin
        // Found one!
        if (SearchRec.Name[1] <> '.') and (SearchRec.Attr and
          faDirectory <> 0) then
          // We do this recursively!
          FilesFromWildcard(Directory + SearchRec.Name, Mask, Files,
            Subdirs, ShowDirs, Multitasking);
        Error := FindNext(SearchRec);
      end;
      FindClose(SearchRec);
    end;
  end;
end;

function ExecuteFile(const FileName, Params, DefaultDir: String; ShowCmd: Integer): THandle;
begin
  Result := ShellExecute(Application.MainForm.Handle, nil,
    pChar(FileName), pChar(Params),
    pChar(DefaultDir), ShowCmd);
end;

function RunAndGetOutput(const Cmd, WorkDir: String;
  LineOutputFunc: TLineOutputFunc;
  CheckAbortFunc: TCheckAbortFunc;
  ShowReturnValue: Boolean;
  pEnvironment:PChar): String;
var
  si: TStartupInfo;
  pi: TProcessInformation;
  nRead: DWORD;
  aBuf: array[0..8192] of char;
  sa: TSecurityAttributes;
  hOutputReadTmp, hOutputRead, hOutputWrite, hInputWriteTmp, hInputRead,
    hInputWrite, hErrorWrite: THandle;
  FOutput: String;
  CurrentLine: String;
  bAbort: boolean;
begin
  FOutput := '';
  CurrentLine := '';

  // Set up the security attributes struct
  sa.nLength := SizeOf(TSecurityAttributes);
  sa.lpSecurityDescriptor := nil;
  sa.bInheritHandle := True;

  // Create the child output pipe
  if not CreatePipe(hOutputReadTmp, hOutputWrite, @sa, 0) then begin
    Result := 'CreatePipe 1 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit; // its of no use to continue. quit
  end;

  // Create a duplicate of the output write handle for the std error
  // write handle. This is necessary in case the child application
  // closes one of its std output handles.
  if not DuplicateHandle(GetCurrentProcess(), hOutputWrite,
    GetCurrentProcess(), @hErrorWrite,
    0, true, DUPLICATE_SAME_ACCESS) then begin
    Result := 'DuplicateHandle 1 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;

  // Create the child input pipe
  if not CreatePipe(hInputRead, hInputWriteTmp, @sa, 0) then begin
    Result := 'CreatePipe 2 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;

  // Create new output read handle and the input write handle. Set
  // the inheritance properties to FALSE. Otherwise, the child inherits
  // the these handles; resulting in non-closeable handles to the pipes
  // being created.
  if not DuplicateHandle(GetCurrentProcess(), hOutputReadTmp,
    GetCurrentProcess(), @hOutputRead,
    0, false, DUPLICATE_SAME_ACCESS) then begin
    Result := 'DuplicateHandle 2 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;

  if not DuplicateHandle(GetCurrentProcess(), hInputWriteTmp,
    GetCurrentProcess(), @hInputWrite,
    0, false, DUPLICATE_SAME_ACCESS) then begin
    Result := 'DuplicateHandle 3 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;

  // Close inheritable copies of the handles you do not want to be
  // inherited.
  if not CloseHandle(hOutputReadTmp) then begin
    Result := 'CloseHandle 1 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;
  if not CloseHandle(hInputWriteTmp) then begin
    Result := 'CloseHandle 2 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;

  // Set up the start up info struct.
  FillChar(si, SizeOf(TStartupInfo), 0);
  si.cb := SizeOf(TStartupInfo);
  si.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
  si.hStdOutput := hOutputWrite;
  si.hStdInput := hInputRead;
  si.hStdError := hErrorWrite;

  // Launch the process that we want to redirect.
  if not CreateProcess(nil, pChar(Cmd), nil, nil, true, 0, nil, pChar(WorkDir), si, pi) then begin
    Result := Format('CreateProcess error: %s %s',[SysErrorMessage(GetLastError),Cmd]);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;

  // Close any unnecessary handles.
  if not CloseHandle(pi.hThread) then begin
    Result := 'CloseHandle 3 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;

  // Close pipe handles (do not continue to modify the parent).
  // You need to make sure that no handles to the write end of the
  // output pipe are maintained in this process or else the pipe will
  // not close when the child process exits and the ReadFile will hang.
  if not CloseHandle(hOutputWrite) then begin
    Result := 'CloseHandle 4 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;
  if not CloseHandle(hInputRead) then begin
    Result := 'CloseHandle 5 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;
  if not CloseHandle(hErrorWrite) then begin
    Result := 'CloseHandle 6 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;

  bAbort := False;
  repeat
    // Ask our caller if he wants us to quit
    if Assigned(CheckAbortFunc) then
      CheckAbortFunc(bAbort);
    if bAbort then begin
      TerminateProcess(pi.hProcess, 1);
      Break;
    end;
    if (not ReadFile(hOutputRead, aBuf, SizeOf(aBuf) - 1, nRead, nil)) or (nRead = 0) then begin
      if GetLastError = ERROR_BROKEN_PIPE then
        Break; // pipe done - normal exit path
    end;
    aBuf[nRead] := #0;
    FOutput := FOutput + pChar(@aBuf[0]);

    if Assigned(LineOutputFunc) then begin
      CurrentLine := CurrentLine + pChar(@aBuf[0]);
      if CurrentLine[Length(CurrentLine)] = #10 then begin
        Delete(CurrentLine, Length(CurrentLine), 1);
        LineOutputFunc(CurrentLine);
        CurrentLine := '';
      end;
    end;
  until False;

  if ShowReturnValue then begin
    GetExitCodeProcess(pi.hProcess, nRead);
    Result := FOutput + ' ' + IntToStr(nRead);
  end else
    Result := FOutput;

  // Close handles we don't need anymore.
  if not CloseHandle(hOutputRead) then begin
    Result := 'CloseHandle 7 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;
  if not CloseHandle(hInputWrite) then begin
    Result := 'CloseHandle 8 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;
  if not CloseHandle(pi.hProcess) then begin // TODO: shouldn't we terminate it?
    Result := 'CloseHandle 9 error: ' + SysErrorMessage(GetLastError);
    LogError('Utils.pas RunAndGetOutput',Result);
    Exit;
  end;
end;

procedure SetPath(const Add: String; UseOriginal: boolean = TRUE);
var
  OldPath: array[0..2048] of char;
  NewPath: String;
begin
  NewPath := Add;

  if NewPath <> '' then
    if NewPath[length(NewPath)] <> ';' then
      NewPath := NewPath + ';';

  // PATH environment variable does *not* like quotes in paths...
  // Even if there are spaces in pathnames, it doesn't matter.
  // It splits them up by the ';'
  NewPath := StringReplace(NewPath, '"', '', [rfReplaceAll]);

  if UseOriginal then
    NewPath := NewPath + devDirs.OriginalPath
  else begin
    GetEnvironmentVariable(pChar('PATH'), @OldPath, SizeOf(OldPath));
    NewPath := NewPath + String(OldPath);
  end;

  SetEnvironmentVariable(pChar('PATH'), pChar(NewPath));
end;

function ValidateFile(const FileName: String; const WorkPath: String; const CheckDirs: boolean = FALSE):
  String;
var
  fName: String;
begin
  fName := ExtractFileName(FileName);
  if FileExists(FileName) then
    result := FileName
  else if FileExists(WorkPath + fName) then
    result := WorkPath + fName
  else if FileExists(WorkPath + FileName) then
    result := FileName
  else if CheckDirs then begin
    if (devDirs.Default <> '') and FileExists(devDirs.Default + fName) then
      result := devDirs.Default + fName
    else if (devDirs.Exec <> '') and FileExists(devDirs.Exec + fName) then
      result := devDirs.Exec + fName
    else if (devDirs.Help <> '') and FileExists(devDirs.Help + fName) then
      result := devDirs.Help + fName
    else if (devDirs.Lang <> '') and FileExists(devDirs.Lang + fName) then
      result := devDirs.Lang + fName
    else if (devDirs.Icons <> '') and FileExists(devDirs.Icons + fName) then
      result := devDirs.Icons + fName
    else if (devDirs.Templates <> '') and FileExists(devDirs.Templates + fName) then
      result := devDirs.Templates + fName;
  end else
    result := '';
end;

function GetShortName(const FileName: String): String;
var
  pFileName: array[0..2048] of char;
begin
  GetShortPathName(pChar(FileName), pFileName, 2048);
  result := StrPas(pFileName);
end;

function BuildFilter(const Filters: array of String): String;
var
  I: integer;
begin
  result := FLT_ALLFILES;
  for I := 0 to high(Filters) do begin

    // Check a few things:
    // 1) result must end with | before appending
    if result[Length(result)] <> '|' then
      result := result + '|';

    result := result + Filters[I];
  end;
end;

function CodeInstoStr(const s: String): String;
begin
  result := StringReplace(s, #13#10, '$_', [rfReplaceAll]);
end;

function StrtoCodeIns(const s: String): String;
begin
  result := StringReplace(s, '$_', #13#10, [rfReplaceAll]);
end;

procedure StrToThemeColor(var tc: TThemeColor; const value: String);
var
  tmp: TStringList;
begin
  tmp := TStringList.Create;
  try
    tmp.CommaText := value;
    if tmp.Count >= 2 then
      with tc do begin
        Foreground := StringtoColor(tmp[0]);
        Background := StringToColor(tmp[1]);
      end
    else
      with tc do begin
        Foreground := clNone;
        Background := clNone;
      end;
  finally
    tmp.Free;
  end;
end;

function ThemeColortoStr(tc: TThemeColor): String;
begin
  result := format('%d, %d', [tc.Foreground, tc.Background]);
end;

function AttrtoStr(Attr: TSynHighlighterAttributes): String;
begin
  result := format('%s, %s, %d, %d, %d',
    [ColortoString(Attr.Foreground),
    ColortoString(Attr.Background),
      ord(fsBold in Attr.Style),
      ord(fsItalic in Attr.Style),
      ord(fsUnderline in Attr.Style)]);
end;

procedure StrtoAttr(var Attr: TSynHighlighterAttributes; const Value: String);
var
  tmp: TStringList;
begin
  tmp := TStringList.Create;
  try
    tmp.commaText := Value;
    if tmp.count = 5 then
      with attr do begin
        Foreground := StringtoColor(tmp[0]);
        Background := StringtoColor(tmp[1]);
        style := [];
        if tmp[2] = '1' then
          style := style + [fsbold]
        else
          style := style - [fsbold];
        if tmp[3] = '1' then
          style := style + [fsItalic]
        else
          style := style - [fsItalic];
        if tmp[4] = '1' then
          style := style + [fsUnderline]
        else
          style := style - [fsUnderline];
      end;
  finally
    tmp.Free;
  end;
end;

function FormatList(const sl: TStrings; formatstr: String): String;
var
  i: integer;
begin
  // Append by using formatstr
  for I := 0 to sl.Count - 1 do
    result := format(formatstr, [result, sl[i]]);
end;

function GetFileTyp(const FileName: String): TExUnitType;
var
  ext: String;
begin
  Ext := ExtractFileExt(FileName);
  if AnsiMatchText(Ext, ['.dev']) then
    result := utPrj
  else if AnsiMatchText(ext, ['.c']) then
    result := utcSrc
  else if AnsiMatchText(ext, ['.cpp', '.cc', '.cxx', '.c++', '.cp']) then
    result := utcppSrc
  else if AnsiMatchText(ext, ['.h']) then
    result := utcHead
  else if AnsiMatchText(ext, ['.hpp', '.rh', '.hh', '.hxx', '.inl']) then
    result := utcppHead
  else if AnsiMatchText(ext, ['.res', '.rc']) then
    result := utresSrc
  else if AnsiMatchText(ext, ['.rh']) then
    result := utresHead
  else
    result := utOther;
end;

// seems stupid now but I want to expand to account for .. chars
//in basepath and or filename

function ExpandFileto(const FileName, BasePath: String): String;
var
  oldPath: String;
begin
  oldPath := GetCurrentDir;
  try
    if DirectoryExists(BasePath) then begin
      chdir(BasePath);
      result := ExpandFileName(FileName);
    end else
      Result := Filename; // no luck...
  finally
    chdir(oldPath);
  end;
end;

function FileSamePath(const FileName, TestPath: String): boolean;
var
  s1, s2: String;
begin
  result := FALSE;
  s1 := ExtractFilePath(FileName);
  s2 := ExtractFilePath(TestPath);
  if (s1 = s2) then
    result := TRUE
  else if (s1 = '') then
    result := FileExists(s2 + FileName);
end;

procedure CloneMenu(FromMenu, ToMenu: TMenuItem);
var
  idx: integer;
  Item: TMenuItem;
begin
  ToMenu.Clear;
  if FromMenu.Count <= 0 then
    exit;
  for idx := 0 to pred(FromMenu.Count) do begin
    Item := TMenuItem.Create(ToMenu);
    with FromMenu.Items[idx] do begin
      Item.Caption := Caption;
      Item.OnClick := OnClick;
      Item.Tag := Tag;
      Item.AutoCheck := AutoCheck;
      Item.ShortCut := ShortCut;
    end;
    ToMenu.Add(Item);
  end;
  ToMenu.Visible := FromMenu.Visible;
end;

function FPos(const SubStr, S: String; start: integer): integer;
var
  i: Integer;
  pStr: PChar;
  pSub: PChar;
begin
  pSub := Pointer(SubStr);

  for i := start to Length(s) do begin
    pStr := @(s[i]);
    if (pStr^ = pSub^) then begin // compare char
      if CompareMem(pSub, pStr, Length(SubStr)) then begin // then compare whole string
        result := i;
        exit;
      end;
    end;
  end;

  result := 0;
end;

function RPos(const SubStr, s: String): integer;
begin
  result := RPos(SubStr, s, Length(s) - Length(SubStr) + 1);
end;

function RPos(const SubStr, S: String; start: integer): integer;
var
  i: Integer;
  pStr: PChar;
  pSub: PChar;
begin
  pSub := Pointer(SubStr);

  for i := start downto 1 do begin
    pStr := @(s[i]);
    if (pStr^ = pSub^) then begin // compare char
      if CompareMem(pSub, pStr, Length(SubStr)) then begin // then compare whole string
        result := i;
        exit;
      end;
    end;
  end;

  result := 0;
end;

function FindComplement(const s: String; fromtoken, totoken: char; var curpos: integer; increment: integer):
  boolean;
var
  level, curposbackup: integer;
begin
  curposbackup := curpos;
  level := 0;
  while (curpos <= Length(s)) and (curpos > 0) do begin
    if (s[curpos] = fromtoken) then begin
      Inc(level);
    end else if (s[curpos] = totoken) then begin
      Dec(level);
      if level = 0 then begin
        Result := true;
        Exit;
      end;
    end;
    Inc(curpos, increment);
  end;
  curpos := curposbackup;
  Result := false;
end;

{ GenMakePath: convert a filename to a format that can be used by make }

function GenMakePath1(const FileName: String): String;
begin
  Result := GenMakePath(FileName, False, True);
end;

function GenMakePath2(const FileName: String): String;
begin
  Result := GenMakePath(FileName, True, False);
end;

function GenMakePath(const FileName: String; EscapeSpaces, EncloseInQuotes: Boolean): String;
begin
  Result := FileName;

  { Convert backslashes to slashes }
  Result := StringReplace(Result, '\', '/', [rfReplaceAll]);

  if EscapeSpaces then
    Result := StringReplace(Result, ' ', '\ ', [rfReplaceAll]);

  if EncloseInQuotes then
    if (Pos(' ', Result) > 0) then
      Result := '"' + Result + '"';
end;

function GetRealPath(const BrokenFileName, Directory: String): String;
var
  e: TEditor;
begin
  Result := BrokenFileName;

  // There are 3 kinds of bad filenames:
  // 1: C:/Foo/Bar.txt              (must be backslashes)
  // 2: /C/WINDOWS/Desktop/foo.c    (WinUnix paths?)
  // 3: foo.c                       (not an absolute filename)

  // First, check if this is a WinUnix path
  if CompareText(Copy(Result, 1, 1), '/') = 0 then begin
    Delete(Result, 1, 2);
    Result[2] := ':';
    Insert('\', Result, 3);
  end;

  // Second, check if this is an absolute filename
  if (Length(Result) < 4) or not ((LowerCase(Result)[1] in ['A'..'Z']) and (Result[2] = ':')) then begin
    // It's not
    if Length(Directory) = 0 then begin
      if Assigned(MainForm.Project) then
        Result := ExpandFileTo(Result, MainForm.Project.Directory)
      else begin
        e := MainForm.EditorList.GetEditor;
        if (Assigned(e)) and (Length(ExtractFileDir(e.FileName)) > 0) then
          Result := ExpandFileTo(Result, ExtractFileDir(e.FileName))
        else
          Result := ExpandFileName(Result);
      end;
    end else begin
      Result := ExpandFileTo(Result, Directory);
    end;
  end;

  // Last, replace all slashes with backslahes
{$IFDEF WIN32}
  Result := StringReplace(Result, '/', '\', [rfReplaceAll]);
{$ENDIF}
end;

function IncludeQuoteIfSpaces(const s: String): String;
begin
  if pos(' ', s) > 0 then
    result := '"' + s + '"'
  else
    result := s;
end;

function IncludeQuoteIfNeeded(const s: String): String;
begin
  if pos('"', s) = 0 then
    result := '"' + s + '"'
  else
    result := s;
end;

// added by mandrav 13 Sep 2002
// returns the file version of the .exe specified by filename
// in the form x.x.x.x

function GetVersionString(const FileName: String): String;
var
  Buf: Pointer;
  i: cardinal;
  P: pointer;
  pSize: cardinal;
  ffi: TVSFixedFileInfo;
begin
  Result := '';
  i := GetFileVersionInfoSize(pChar(FileName), i);
  if i = 0 then
    Exit;

  Buf := AllocMem(i);
  try
    if not GetFileVersionInfo(pChar(FileName), 0, i, Buf) then
      Exit;

    pSize := SizeOf(P);
    VerQueryValue(Buf, '\', p, pSize);

    ffi := TVSFixedFileInfo(p^);
    Result := Format('%d.%d.%d.%d', [
      HiWord(ffi.dwFileVersionMS),
        LoWord(ffi.dwFileVersionMS),
        HiWord(ffi.dwFileVersionLS),
        LoWord(ffi.dwFileVersionLS)]);
  finally
    FreeMem(Buf);
  end;
end;

function GetAssociatedProgram(const Extension: String; var Filename, Description: String): boolean;
const
  NOVALUE = '$__NONE__$';
var
  R: TRegIniFile;
  Base, S: String;
begin
  Result := False;
  R := TRegIniFile.Create;
  try
    R.RootKey := HKEY_CLASSES_ROOT;
    Base := R.ReadString(Extension, '', NOVALUE);
    if S = NOVALUE then
      Exit;
    S := R.ReadString(Base + '\shell\open\command', '', NOVALUE);
    if S = NOVALUE then
      Exit;
    Filename := S; // filename probably contains args, e.g. Filename='"some where\my.exe" "%1"'

    Description := ExtractFilename(S);
    Result := True;
    S := R.ReadString(Base + '\shell\open\ddeexec\application', '', NOVALUE);
    if S = NOVALUE then
      Description := 'Default application'
    else
      Description := S;
    if S = 'DEVCPP' then // avoid extensions registered to DevCpp ;)
      Result := False;
  finally
    R.Free;
  end;
end;

function IsNumeric(const s: String): boolean;
var
  i: integer;
begin
  result := true;
  for i := 1 to length(s) do
    if not (s[i] in ['0'..'9']) then begin
      result := false;
      exit;
    end;
end;

function CountChar(const s: String; c: char): integer;
var
  i: integer;
begin
  result := 0;
  for i := 1 to length(s) do
    if s[i] = c then
      Inc(result);
end;

function NewSelectDirectoryCallback(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpdata);
  result := 0;
end;

function NewSelectDirectory(const Caption: string; const Root: WideString; var Directory: string): Boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  OldErrorMode: Cardinal;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
begin
  Result := False;
  if not DirectoryExists(Directory) then
    Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do begin
        hwndOwner := Application.Handle;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS or BIF_USENEWUI; // FIX
        if Directory <> '' then begin
          lpfn := NewSelectDirectoryCallback;
          lParam := Integer(PChar(Directory));
        end;
      end;
      WindowList := DisableTaskWindows(0);
      OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        SetErrorMode(OldErrorMode);
        EnableTaskWindows(WindowList);
      end;
      Result := ItemIDList <> nil;
      if Result then begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

function GetFileSize(const FileName: String): integer;
var
  F: TSearchRec;
begin
  if FindFirst(FileName, faAnyFile, F) = 0 then
    Result := F.Size
  else
    Result := 0;
end;

function FormatFileSize(Size: integer): String;
begin
  if Size = 0 then
    Result := '0'
  else if Size < 1024 then
    Result := IntToStr(Size) + ' ' + Lang[ID_BYTES]
  else if Size < 1024 * 1024 then
    Result := FloatToStr(Size / 1024) + ' KiB'
  else if Size < 1024 * 1024 * 1024 then
    Result := FloatToStr((Size / 1024) / 1024) + ' MiB'
  else
    Result := FloatToStr(((Size / 1024) / 1024) / 1024) + ' GiB';
end;

function ShortenLogOutput(const Input: String): String;
var
  I: integer;
begin
  // Shorten compiler paths
  Result := Input;
  if devData.ShortenCompPaths and Assigned(devCompilerSets.CompilationSet) then begin
    with devCompilerSets.CompilationSet do begin
      for I := 0 to BinDir.Count - 1 do
        Result := StringReplace(Result, BinDir[i], '%BinDir' + IntToStr(i) + '%', [rfReplaceAll]);
      for I := 0 to CppDir.Count - 1 do
        Result := StringReplace(Result, CppDir[i], '%CppIncludeDir' + IntToStr(i) + '%', [rfReplaceAll]);
      for I := 0 to CDir.Count - 1 do
        Result := StringReplace(Result, CDir[i], '%CIncludeDir' + IntToStr(i) + '%', [rfReplaceAll]);
      for I := 0 to LibDir.Count - 1 do
        Result := StringReplace(Result, LibDir[i], '%LibDir' + IntToStr(i) + '%', [rfReplaceAll]);
    end;
    Result := StringReplace(Result, devDirs.Exec, '%Dev-Cpp%\', [rfReplaceAll]);
  end;
end;

function AnsiToUnicode(s:String):WideString;
var
  lpWC : PWideChar;
  len:integer;
begin
  len := (Length(s)+1)*4;
  lpWC := AllocMem(len);
  MultibyteToWideChar(CP_ACP,0,PChar(s),Length(s),
    lpWC,len);
  Result :=lpWC;
  FreeMem(lpWC);
end;

function UTF8ToUnicode(s:String):WideString;
var
  lpWC : PWideChar;
  len:integer;
begin
  len := (Length(s)+1)*4;
  lpWC := AllocMem(len);
  MultibyteToWideChar(CP_UTF8,0,PChar(s),Length(s),
    lpWC,len);
  Result :=lpWC;
  FreeMem(lpWC);
end;

function UnicodeToUTF8(s:WideString):String;
var
  lpC : PChar;
  len:integer;
begin
  len := (Length(s)+1)*4;
  lpC := AllocMem(len);
  WideCharToMultibyte(CP_UTF8,0,PWideChar(s),Length(s),
    lpC,len,nil,nil);
  Result :=lpC;
  FreeMem(lpC);
end;

function UnicodeToAnsi(s:WideString):String;
var
  lpC : PChar;
  len:integer;
begin
  len := (Length(s)+1)*4;
  lpC := AllocMem(len);
  WideCharToMultibyte(CP_ACP,0,PWideChar(s),Length(s),
    lpC,len,nil,nil);
  Result :=lpC;
  FreeMem(lpC);
end;

function AnsiToUTF8(s:String):String;
var
  ws: WideString;
begin
  ws := AnsiToUnicode(s);
  Result:= UnicodeToUTF8(ws);
end;

function UTF8ToAnsi(s:String):String;
var
  ws: WideString;
begin
  ws := UTF8ToUnicode(s);
  Result:= UnicodeToAnsi(ws);
end;

function GetSystemCharsetName():String;
var
  acp: cardinal;
begin
  acp := GetACP();
  Result := GetCodePage(acp).Name;
end;

function GetLanguageFileName():String;
var
  acp: cardinal;
begin
  acp := GetACP();
  Result := GetCodePage(acp).Language;
  if Result = '' then begin
    Result := 'english';
  end;
end;

{
utf-8������ı��ĵ����еĴ���BOM (Byte Order Mark, �ֽ����־)����0xEF, 0xBB,0xBF���е�û�С���Windows��notepad�༭���ı������ǻ��Զ����BOM�����ǳ���UE�༭���ڱ���utf-8�����ʱ��Ҳ���Զ����BOM��Notepad++Ĭ�������б���utf-8����ʱ����BOM�ġ������ı��༭����û�г��Թ�������Ȥ�Ŀ����Լ����ԡ� 
����utf-8��һ�ֶ��ֽڱ�����ַ�������ʾһ��Unicode�ַ�ʱ����������1��������ֽڡ������ı�ȫ����ASCII�ַ�ʱutf-8�Ǻ�ASCIIһ�µ�(utf-8���¼���ASCII)��utf-8�ֽ���������ʾ��

1�ֽڣ�0xxxxxxx 
2�ֽڣ�110xxxxx 10xxxxxx 
3�ֽڣ�1110xxxx 10xxxxxx 10xxxxxx

��������utf-8������������֤�����磺 
������һ���ַ��ĵ�һ���ֽڵĵ�һ��bitΪ0��˵���Ǹ�ANSII�ַ��������鿴�ڶ����ַ�������һ��������1����鿴�ڶ������أ����ڶ�������Ϊ1�������Ϊ1˵���ⲻ��һ��utf-8������ı�������ڶ�������Ϊ1����鿴����������Ϊ0����Ϊ0��˵������utf-8����,�����0��˵�����ַ�������2�ֽڵ�utf-8���鿴���ַ��ĵڶ����ֽڣ����ǰ�������ط���10��˵������һ��utf-8������ַ����������ƣ���һ����һ��bit������UTF-8����Ҫ�󣬾��ж��ı�ΪANSI��GBK������ֱ���ı�����������utf-8���������˵���ı���UTF-8����ġ� 
����������������֪�ַ��ĵ�һ���ֽ��������0x80��0xC0֮������0xF0�򲻷���utf-8�ı�����򣬿�ֱ���жϲ���utf-8������ı��������һ���ֽڷ���utf-8������С��0xC0���жϵڶ����ֽڣ�����ڶ����ֽں�0xC0��������������0x80����жϲ���utf-8������ı����������ƣ������һ���ֽڽ���0xE0��0xF0֮�䣬�ҵڶ����ֽڷ��Ϲ��򣬵������ֽ���ڶ����ֽ���ͬ���жϣ�������Ϲ�������ַ���utf-8�ַ����ж���һ���ַ�ֱ���ı�������
}
function GetFileEncodingType(s:String):TFileEncodingType;
var
  allAscii: boolean;
  ii: Integer;
  tmp: Byte;
  buffer: PChar;
  size: Int64;
begin
  allAscii := True;
  buffer := PChar(s);
  size := Length(s);
  ii := 0;
  while ii < size do
  begin
    tmp := Byte(buffer[ii]);
    if tmp < $80 then        //ֵС��0x80��ΪASCII�ַ�
      Inc(ii)
    else if tmp < $C0 then begin   //ֵ����0x80��0xC0֮���Ϊ��ЧUTF-8�ַ�
      Result := etOther;
      Exit;
    end else if tmp < $E0 then begin   //�˷�Χ��Ϊ2�ֽ�UTF-8�ַ�
      if ii >= (size - 1) then begin
        Result := etOther;
        Exit;
      end;
      if (Byte(buffer[ii + 1]) and $C0) <> $80 then begin
        Result := etOther;
        Exit;
      end;
      allAscii := False;
      Inc(ii, 2);
    end else if tmp < $F0 then begin //�˷�Χ��Ϊ3�ֽ�UTF-8�ַ�
      if ii >= size - 2 then begin
        Result := etOther;
        Exit;
      end;
      if ((Byte(buffer[ii + 1]) and $C0) <> $80) or
       ((Byte(buffer[ii + 2]) and $C0) <> $80) then begin
        Result := etOther;
        Exit;
      end;
      allAscii := False;
      Inc(ii, 3);
    end else begin
      Result := etOther;
      Exit;
    end; 
  end;
  if allAscii then
    Result := etAscii
  else
    Result := etUTF8;
end;

function ShowInputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  oldName:TFontDataName;
  oldHeight: integer;
begin
  oldName:=Graphics.DefFontData.Name;
  oldHeight:=Graphics.DefFontData.Height;
  Graphics.DefFontData.Name:=Application.MainForm.Font.Name;
  Graphics.DefFontData.Height:=Application.MainForm.Font.Height;
  Result:=InputQuery(ACaption, APrompt,Value);
  Graphics.DefFontData.Name:=oldName;
  Graphics.DefFontData.Height:=oldHeight;

end;

function ShowInputBox(const Caption, Prompt, Default : string): String;
var
  oldName:TFontDataName;
  oldHeight: integer;
begin
  oldName:=Graphics.DefFontData.Name;
  oldHeight:=Graphics.DefFontData.Height;
  Graphics.DefFontData.Name:=Application.MainForm.Font.Name;
  Graphics.DefFontData.Height:=Application.MainForm.Font.Height;
  Result:=InputBox(Caption, Prompt,Default);
  Graphics.DefFontData.Name:=oldName;
  Graphics.DefFontData.Height:=oldHeight;

end;

function IsIdentifier(const s:string):boolean;
var
  i:integer;
  len:integer;
begin
  Result:=False;
  len := Length(s);
  if len<=0 then
    Exit;
  if not (s[1] in ['_','a'..'z','A'..'Z']) then
    Exit;
  for i:=2 to len do begin
    if not (s[i] in ['_','0'..'9','a'..'z','A'..'Z']) then
      Exit;
  end;
  Result:=True;
end;

function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpdata);
  result := 0;
end;



function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string): Boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  OldErrorMode: Cardinal;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
begin
  Result := False;
  if not DirectoryExists(Directory) then
    Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then
      begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do
      begin
        hwndOwner := Application.Handle;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS or BIF_USENEWUI;
        if Directory <> '' then
        begin
          lpfn := SelectDirCB;
          lParam := Integer(PChar(Directory));
        end;
      end;
      WindowList := DisableTaskWindows(0);
      OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        SetErrorMode(OldErrorMode);
        EnableTaskWindows(WindowList);
      end;
      Result :=  ItemIDList <> nil;
      if Result then
      begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;


procedure AppendToFile(filename:String; text:String);
var
  fs:TFileStream;
  mode: integer;
begin
  mode := fmOpenWrite;
  if not FileExists(filename) then
    mode := mode or fmCreate;
  fs:=TFileStream.Create(filename,mode);
  try
    fs.Seek(0,soEnd);
    fs.Write(text[1], Length(text)*sizeof(Char));
  finally
    fs.Free;
  end;
end;

procedure AppendToFile(filename:String; strings:TStrings);
begin
  if not Assigned(Strings) then
    Exit;
  AppendToFile(filename,strings.Text+#13#10);
end;

procedure LogError(source:String; msg:String);
begin
  AppendToFile(IncludeTrailingPathDelimiter(devDirs.config) + DEV_ERROR_LOG_FILE,
    Format('%s %s: %s'#13#10,[FormatDateTime('yyyy/mm/dd tt',Now),source,msg]));

end;

function CreateDirRecursive(const Dir: string): Boolean;
var
  parentDir:String;
begin
  parentDir :=  ExcludeTrailingPathDelimiter( ExtractFilePath(Dir));
  if parentDir=Dir then begin
    Result:=False;
    Exit;
  end;
  if not DirectoryExists(parentDir) then begin
    Result:=CreateDirRecursive(parentDir);
    if not Result then
      Exit;
  end;
  Result:=CreateDir(Dir);
end;


end.

