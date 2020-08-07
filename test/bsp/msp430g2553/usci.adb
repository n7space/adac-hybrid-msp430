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

with dio;
use dio;
with cpu;
use cpu;

package body usci is

    package body a0 is

        package body uart is
            procedure Init is
            begin
                ControlRegister1 := ControlRegister1 or SOFTWARE_RESET_ENABLE;
                ControlRegister0 := 0;
                ControlRegister1 := SOFTWARE_RESET_ENABLE;

                port1.DirectionRegister := port1.DirectionRegister or 4;
                port1.ModeRegister1 := port1.ModeRegister1 or 6;
                port1.ModeRegister2 := port1.ModeRegister2 or 6;
                port1.OutputRegister := 0;
                ControlRegister1 := ControlRegister1 and (not SOFTWARE_RESET_ENABLE);
            end Init;

            procedure Write(data : in uint8_t) is
            begin
                while (InterruptFlagRegister and USCI_A0_TX_INTERRUPT) = 0 loop
                    null;
                end loop;
                TransmissionBuffer := data;
            end Write;

            procedure WriteArray(data : in uint8_array_t) is
            begin
                for i in data'Range loop
                    write(data(i));
                end loop;
            end WriteArray;

            function Read return uint8_t is
            begin
                while (InterruptFlagRegister and USCI_A0_RX_INTERRUPT) = 0 loop
                    null;
                end loop;
                return ReceptionBuffer;
            end Read;

            procedure ReadArray(data : in out uint8_array_t; size : out size_t; maxSize : in size_t; terminator : in uint8_t) is
                x : uint8_t;
            begin
                for i in 1..maxSize loop
                    x := read;
                    if x = terminator then
                        size := i - 1;
                        return;
                    end if;
                    data(Integer(i)) := x;
                end loop;
                size := maxSize;
            end ReadArray;

        end uart;

    end a0;

end usci;
