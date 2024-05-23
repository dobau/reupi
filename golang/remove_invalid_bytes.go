func RemoveInvalidBytes(in string) string {
	fixUtf := func(r rune) rune {
		if !unicode.IsPrint(r) {
			return -1
		}
		return r
	}

	return strings.Map(fixUtf, in)
}

// Unmarshal clean and unmarshal the data into the given interface.
func Unmarshal(data []byte, v any) error {
	dataCleaned := RemoveInvalidBytes(string(data))
	return json.Unmarshal([]byte(dataCleaned), v)
}
