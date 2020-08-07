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

package AdaModule is

    function test_int16Add return Boolean;
    function test_int32Add return Boolean;
    function test_floatAdd return Boolean;
    function test_addInt32AndFloat return Boolean;
    function test_addInt16AndFloat return Boolean;
    function test_addMany return Boolean;

end AdaModule;
