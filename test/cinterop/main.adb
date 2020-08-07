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

with AdaModule;
use AdaModule;

with reporting;

procedure Main is
  failed : Boolean := False;
begin
    reporting.Init;
    if not test_int16Add then
        failed := True;
        reporting.ReportError(0);
    end if;
    if not test_int32Add then
        failed := True;
        reporting.ReportError(1);
    end if;
    if not test_floatAdd then
        failed := True;
        reporting.ReportError(2);
    end if;
    if not test_addInt32AndFloat then
        failed := True;
        reporting.ReportError(3);
    end if;
    if not test_addInt16AndFloat then
        failed := True;
        reporting.ReportError(4);
    end if;
    if not test_addMany then
        failed := True;
        reporting.ReportError(5);
    end if;

    if not failed then
        reporting.ReportSuccess;
    end if;
    loop
        null;
    end loop;
end Main;
