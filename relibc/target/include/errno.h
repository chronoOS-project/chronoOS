#ifndef _RELIBC_ERRNO_H
#define _RELIBC_ERRNO_H

#include <bits/errno.h>

#define E2BIG 7

#define EACCES 13

#define EADDRINUSE 98

#define EADDRNOTAVAIL 99

#define EADV 68

#define EAFNOSUPPORT 97

#define EAGAIN 11

#define EALREADY 114

#define EBADE 52

#define EBADF 9

#define EBADFD 77

#define EBADMSG 74

#define EBADR 53

#define EBADRQC 56

#define EBADSLT 57

#define EBFONT 59

#define EBUSY 16

#define ECANCELED 125

#define ECHILD 10

#define ECHRNG 44

#define ECOMM 70

#define ECONNABORTED 103

#define ECONNREFUSED 111

#define ECONNRESET 104

#define EDEADLK 35

#define EDEADLOCK 58

#define EDESTADDRREQ 89

#define EDOM 33

#define EDOTDOT 73

#define EDQUOT 122

#define EEXIST 17

#define EFAULT 14

#define EFBIG 27

#define EHOSTDOWN 112

#define EHOSTUNREACH 113

#define EIDRM 43

#define EILSEQ 84

#define EINPROGRESS 115

#define EINTR 4

#define EINVAL 22

#define EIO 5

#define EISCONN 106

#define EISDIR 21

#define EISNAM 120

#define EKEYEXPIRED 127

#define EKEYREJECTED 129

#define EKEYREVOKED 128

#define EL2HLT 51

#define EL2NSYNC 45

#define EL3HLT 46

#define EL3RST 47

#define ELIBACC 79

#define ELIBBAD 80

#define ELIBEXEC 83

#define ELIBMAX 82

#define ELIBSCN 81

#define ELNRNG 48

#define ELOOP 40

#define EMEDIUMTYPE 124

#define EMFILE 24

#define EMLINK 31

#define EMSGSIZE 90

#define EMULTIHOP 72

#define ENAMETOOLONG 36

#define ENAVAIL 119

#define ENETDOWN 100

#define ENETRESET 102

#define ENETUNREACH 101

#define ENFILE 23

#define ENOANO 55

#define ENOBUFS 105

#define ENOCSI 50

#define ENODATA 61

#define ENODEV 19

#define ENOENT 2

#define ENOEXEC 8

#define ENOKEY 126

#define ENOLCK 37

#define ENOLINK 67

#define ENOMEDIUM 123

#define ENOMEM 12

#define ENOMSG 42

#define ENONET 64

#define ENOPKG 65

#define ENOPROTOOPT 92

#define ENOSPC 28

#define ENOSR 63

#define ENOSTR 60

#define ENOSYS 38

#define ENOTBLK 15

#define ENOTCONN 107

#define ENOTDIR 20

#define ENOTEMPTY 39

#define ENOTNAM 118

#define ENOTRECOVERABLE 131

#define ENOTSOCK 88

#define ENOTTY 25

#define ENOTUNIQ 76

#define ENXIO 6

#define EOPNOTSUPP 95

#define EOVERFLOW 75

#define EOWNERDEAD 130

#define EPERM 1

#define EPFNOSUPPORT 96

#define EPIPE 32

#define EPROTO 71

#define EPROTONOSUPPORT 93

#define EPROTOTYPE 91

#define ERANGE 34

#define EREMCHG 78

#define EREMOTE 66

#define EREMOTEIO 121

#define ERESTART 85

#define EROFS 30

#define ESHUTDOWN 108

#define ESOCKTNOSUPPORT 94

#define ESPIPE 29

#define ESRCH 3

#define ESRMNT 69

#define ESTALE 116

#define ESTRPIPE 86

#define ETIME 62

#define ETIMEDOUT 110

#define ETOOMANYREFS 109

#define ETXTBSY 26

#define EUCLEAN 117

#define EUNATCH 49

#define EUSERS 87

#define EWOULDBLOCK 41

#define EXDEV 18

#define EXFULL 54

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

int *__errno(void);

int *__errno_location(void);

char **__program_invocation_name(void);

char **__program_invocation_short_name(void);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus

#endif /* _RELIBC_ERRNO_H */
