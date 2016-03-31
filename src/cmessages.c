#include "cmessages.h"

const msg_t MSGT = { .ok = TRUE };
const msg_t MSGF = { .ok = FALSE };

msg_t make_msg(const char *fmt, ...) {
    msg_t msg = { .ok = FALSE };
    va_list vargs;
    va_start(vargs, fmt);
    vsnprintf(msg.msg, CMSGLEN, fmt, vargs);
    va_end(vargs);
    return msg;
}

const char * guessType(SEXP x) {
    SEXP attr = getAttrib(x, R_ClassSymbol);
    if (!isNull(attr))
        return CHAR(STRING_ELT(attr, 0));

    attr = getAttrib(x, R_DimSymbol);
    if (!isNull(attr) && isVectorAtomic(x))
        return length(attr) == 2 ? "matrix" : "array";

    return type2char(TYPEOF(x));
}

SEXP make_type_error(SEXP x, const char *expected) {
    char msg[CMSGLEN];
    snprintf(msg, CMSGLEN, "Must be of type '%s', not '%s'", expected, guessType(x));
    return ScalarString(mkChar(msg));
}
