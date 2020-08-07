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

with Interfaces;
use Interfaces;

with BASIC_SDL_DATAVIEW;
use BASIC_SDL_DATAVIEW;
with TASTE_BasicTypes;
use TASTE_BasicTypes;

with basicsdl;

with guistub;

with reporting;

procedure Main is
  x : aliased asn1SccT_Int32;
  failed : Boolean := False;

begin
    reporting.Init;
    x := 10;
    basicsdl.toSdl(x'access);
    if guistub.result /= True then
        failed := True;
        reporting.ReportError(1);
    end if;

    if guistub.count /= 1 then
        failed := True;
        reporting.ReportError(2);
    end if;

    x := -10;
    basicsdl.toSdl(x'access);

    if guistub.result /= False then
        failed := True;
        reporting.ReportError(3);
    end if;

    if guistub.count /= 2 then
        failed := True;
        reporting.ReportError(4);
    end if;

    if not failed then
        reporting.ReportSuccess;
    end if;
    loop
        null;
    end loop;
end;
