public function CheckComputableANTLR(string x, string[] values) returns boolean {
    foreach string item in values {
        if item == x {
            return true;
        }
    }

    return false;
}