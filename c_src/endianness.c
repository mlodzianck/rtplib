/*
 *   This is a simple compatibility shim to convert
 *     Linux endian macros to the Mac OS X equivalents.
 *       It is public domain.
 * */

#ifdef __APPLE__

#include <libkern/OSByteOrder.h>

#define htobe16(x) OSSwapHostToBigInt16(x)
#define htole16(x) OSSwapHostToLittleInt16(x)
#define be16toh(x) OSSwapBigToHostInt16(x)
#define le16toh(x) OSSwapLittleToHostInt16(x)

#define htobe32(x) OSSwapHostToBigInt32(x)
#define htole32(x) OSSwapHostToLittleInt32(x)
#define be32toh(x) OSSwapBigToHostInt32(x)
#define le32toh(x) OSSwapLittleToHostInt32(x)

#define htobe64(x) OSSwapHostToBigInt64(x)
#define htole64(x) OSSwapHostToLittleInt64(x)
#define be64toh(x) OSSwapBigToHostInt64(x)
#define le64toh(x) OSSwapLittleToHostInt64(x)

#else

#include <endian.h>

#endif

#include <stdint.h>
#include <stddef.h>

htobe16_map(int16_t* buffer, size_t size)
{
	size_t i = 0;
	for(i = 0; i < size; i++)
		buffer[i] = htobe16(buffer[i]);
}
