% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class-cwl.R
\docType{class}
\name{WorkflowStepInput-class}
\alias{WorkflowStepInput-class}
\alias{WorkflowStepInput}
\alias{WorkflowStepOutput-class}
\alias{WorkflowStepOutput}
\alias{WorkflowStepInputList}
\alias{WorkflowStepInputList-class}
\alias{WorkflowStepOutputList}
\alias{WorkflowStepOutputList-class}
\alias{WorkflowStepList}
\alias{WorkflowStepList-class}
\alias{WorkflowStep-class}
\alias{WorkflowStep}
\title{WorkflowStepInputList}
\usage{
WorkflowStepInputList(...)

WorkflowStepOutputList(...)

WorkflowStepList(...)
}
\arguments{
\item{\dots}{element or list of the element.}
}
\value{
a WorkflowStep object or subclass object.
}
\description{
A workflow step is an executable element of a workflow.
It specifies the underlying process implementation (such as
CommandLineTool) in the run field and connects the input and output
parameters of the underlying process to workflow parameters.
}
\section{Fields}{

\describe{
\item{\code{id}}{[character] The unique identifier for this workflow step.}

\item{\code{inputs}}{(WorkflowStepInputList) Defines the input parameters
of the workflow step. The process is ready to run when all required
input parameters are associated with concrete values. Input
parameters include a schema for each parameter and is used to
validate the input object, it may also be used build a user
interface for constructing the input object.}

\item{\code{outputs}}{(WorkflowStepOutputList) Defines the parameters
representing the output of the process. May be used to generate
and/or validate the output object.}

\item{\code{requirements}}{[ProcessRequirement] Declares requirements that
apply to either the runtime environment or the workflow engine that
must be met in order to execute this workflow step. If an
implementation cannot satisfy all requirements, or a requirement is
listed which is not recognized by the implementation, it is a fatal
error and the implementation must not attempt to run the process,
unless overridden at user option.}

\item{\code{hints}}{[ANY] Declares hints applying to either the runtime
environment or the workflow engine that may be helpful in executing
this workflow step. It is not an error if an implementation cannot
satisfy all hints, however the implementation may report a warning.}

\item{\code{label}}{[character] A short, human-readable label of this
process object.}

\item{\code{description}}{[character] A long, human-readable description
of this process object.}

\item{\code{run}}{(CommandLineToolORExpressionToolORWorkflow) Specifies
the process to run.}

\item{\code{scatter}}{[character]}

\item{\code{scatterMethod}}{[ScatterMethod] Required if scatter is an array of more
than one element.}
}}


\section{WorkflowStepInput Class}{

\describe{

The input of a workflow step connects an upstream parameter (from
the workflow inputs, or the outputs of other workflows steps) with
the input parameters of the underlying process.

If the sink parameter is an array, or named in a workflow scatter
operation, there may be multiple inbound data links listed in the
connect field. The values from the input links are merged depending
on the method specified in the linkMerge field. If not specified,
the default method is merge_nested:

\item{merge_nested}{ The input shall be an array consisting of
exactly one entry for each input link. If merge_nested is specified
with a single link, the value from the link is wrapped in a
single-item list.  }

\item{merge_flattened}{ 1) The source and sink parameters must be
compatible types, or the source type must be compatible with single
element from the "items" type of the destination array
parameter. 2) Source parameters which are arrays are concatenated;
source parameters which are single element types are appended as
single elements.  }

Fields:

\item{\code{id}}{ (character) A unique identifier for this workflow input
parameter.}

\item{\code{source}}{[character] Specifies one or more workflow parameters
that will provide input to the underlying process parameter.}

\item{\code{linkMerge}}{[LineMergeMethod] The method to use to merge
multiple inbound links into a single array. If not specified, the
default method is merge_nested:}

\item{\code{default}}{ [ANY] The default value for this parameter if there
is no source field.}
}
}

\section{WorkflowStepOutput Class}{

\describe{

Associate an output parameter of the underlying process with a
workflow parameter. The workflow parameter (given in the id field)
be may be used as a source to connect with input parameters of
other workflow steps, or with an output parameter of the process.

\item{\code{id}}{ (character) A unique identifier for this workflow output
parameter. This is the identifier to use in the source field of
WorkflowStepInput to connect the output value to downstream
parameters.}

}
}

\section{Scatter/gather}{


To use scatter/gather, ScatterFeatureRequirement must be specified
in the workflow or workflow step requirements.

A "scatter" operation specifies that the associated workflow step
or subworkflow should execute separately over a list of input
elements. Each job making up a scatter operaution is independent
and may be executed concurrently.

The scatter field specifies one or more input parameters which will
be scattered. An input parameter may be listed more than once. The
declared type of each input parameter is implicitly wrapped in an
array for each time it appears in the scatter field. As a result,
upstream parameters which are connected to scattered parameters may
be arrays.

All output parameters types are also implicitly wrapped in arrays;
each job in the scatter results in an entry in the output array.

If scatter declares more than one input parameter, scatterMethod
describes how to decompose the input into a discrete set of jobs.

\itemize{

\item{dotproduct}{ specifies that each the input arrays are aligned
and one element taken from each array to construct each job. It is
an error if all input arrays are not the same length.}

\item{nested_crossproduct}{specifies the cartesian product of the
inputs, producing a job for every combination of the scattered
inputs. The output must be nested arrays for each level of
scattering, in the order that the input arrays are listed in the
scatter field.}

\item{flat_crossproduct}{specifies the cartesian product of the
inputs, producing a job for every combination of the scattered
inputs. The output arrays must be flattened to a single level, but
otherwise listed in the order that the input arrays are listed in
the scatter field.}

}
}

\section{Subworkflows}{


To specify a nested workflow as part of a workflow step,
SubworkflowFeatureRequirement must be specified in the workflow or
workflow step requirements.
}

\examples{
ws <- WorkflowStepList(WorkflowStep(
  id = "step1", label = "align-and-sort",
  description = "align and sort",
  inputs = WorkflowStepInputList(
    WorkflowStepInput(id = "id1"),
    WorkflowStepInput(id = "id2")
  )
))
}
