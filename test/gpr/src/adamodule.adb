with utils;
use utils;

package body AdaModule is

function addInt32(a : int32_t; b : int32_t) return int32_t is
begin
    return a + b;
end addInt32;

end AdaModule;