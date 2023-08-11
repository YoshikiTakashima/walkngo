#!/bin/sed -f

# Re-write constructor (make)
s/ = make(std::vector<std::vector<int>>,\(.*\))/(\1, std::vector<int>(0))/g
s/ = make(std::vector<int>,\(.*\))/(\1, 0)/g

s/ = make(std::vector<std::vector<bool>>,\(.*\))/(\1, std::vector<bool>(0))/g
s/ = make(std::vector<bool>,\(.*\))/(\1, 0)/g

s/std::vector<std::vector<uint8>> \(.*\) = make(std::vector<std::vector<uint8>>,\(.*\))/std::vector<uint8_t> \1(\2, std::vector<uint8_t>(0))/g
s/std::vector<uint8> \(.*\) = make(std::vector<uint8>,\(.*\))/std::vector<uint8_t> \1(\2, 0)/g

s/.*std::map<.* \(.*\) = make(\(.*\));/\2 \1;/g


# Re-write vector append. Note that these re-write rules fail under the
# following cases: (1) in the return case, it will fail when it needs deepcopy
# and (2) the = case when the LHS of the assignment is not the same as \1.

s/return append(\(.*\),\(.*\));/\1.push_back(\2); return \1;/g
s/ = append(\(.*\),\(.*\));/.push_back(\2);/g

# Re-write prelude includes
s/#include <go.h>/#include <vector>\
#include <tuple>\
#include <map>/g

