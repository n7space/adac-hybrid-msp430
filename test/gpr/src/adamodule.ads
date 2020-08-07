with utils;
use utils;

package AdaModule is

function addInt32(a : int32_t; b : int32_t) return int32_t;
pragma Export(C, addInt32, "addInt32");

end AdaModule;