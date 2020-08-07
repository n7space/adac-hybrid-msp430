-- This file is part of the adac-hybrid-msp430 distribution
-- Copyright (C) 2020, European Space Agency
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-- General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

with usci;
with utils;
use utils;

package body reporting is

    ERROR_STRING : constant String := "Error:";
    SUCCESS_STRING : constant String := "Success";
    TERMINATOR : constant uint8_array_t := (1 => 10); -- New Line

    buffer : uint8_array_t(1..Integer(usci.size_t'Last));

    procedure Init is
    begin
        usci.a0.uart.Init;
    end Init;

    procedure ReportError(errorNo : in Integer) is
    begin
        StringToArray(buffer, ERROR_STRING);
        usci.a0.uart.writeArray(buffer(ERROR_STRING'First..ERROR_STRING'Last));
        declare
            code : String := Integer'Image(errorNo);
        begin
            StringToArray(buffer, code);
            usci.a0.uart.writeArray(buffer(code'First..code'Last));
        end;
        usci.a0.uart.writeArray(TERMINATOR);
    end ReportError;

    procedure ReportErrorString(error : in String) is
    begin
        StringToArray(buffer, ERROR_STRING);
        usci.a0.uart.writeArray(buffer(ERROR_STRING'First..ERROR_STRING'Last));
        StringToArray(buffer, error);
        usci.a0.uart.writeArray(buffer(error'First..error'Last));
        usci.a0.uart.writeArray(TERMINATOR);
    end ReportErrorString;

    procedure ReportInfo(msg : in String) is
    begin
        StringToArray(buffer, msg);
        usci.a0.uart.writeArray(buffer(msg'First..msg'Last));
        usci.a0.uart.writeArray(TERMINATOR);
    end ReportInfo;

    procedure ReportSuccess is
    begin
        StringToArray(buffer, SUCCESS_STRING);
        usci.a0.uart.writeArray(buffer(SUCCESS_STRING'First..SUCCESS_STRING'Last));
        usci.a0.uart.writeArray(TERMINATOR);
    end ReportSuccess;

end reporting;
