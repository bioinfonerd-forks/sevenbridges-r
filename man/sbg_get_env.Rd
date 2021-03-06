% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class-auth-utils.R
\name{sbg_get_env}
\alias{sbg_get_env}
\title{Set authentication environment variables for Seven Bridges API}
\usage{
sbg_get_env(x)
}
\arguments{
\item{x}{Name of the system environment variable}
}
\value{
value of the environment variable
}
\description{
Set authentication environment variables for Seven Bridges API
}
\examples{
# set and get two environment variables for CGC
token <- "your_token"
\dontrun{
sbg_set_env("https://cgc-api.sbgenomics.com/v2", token)
sbg_get_env("SB_API_ENDPOINT")
sbg_get_env("SB_AUTH_TOKEN")}
}
