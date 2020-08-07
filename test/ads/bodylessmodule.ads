with utils;
use utils;

package BodylessModule is

function functionInHeader(a : int32_t) return int32_t is (a * a + 1);
pragma Export(C, functionInHeader, "functionInHeader");

end BodylessModule;