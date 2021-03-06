abstract Record

getdict(rec::Record) = rec.dict
Base.getindex(rec::Record, key) = rec.dict[key]
Base.keys(rec::Record) = keys(rec.dict)

type DefaultRecord <: Record
    dict::Dict{Symbol, Any}

    function DefaultRecord(args::Dict)
        trace = StackTraces.remove_frames!(
            StackTraces.stacktrace(),
            [:DefaultRecord, :log, Symbol("#log#22"), :info, :warn, :debug]
        )

        new(Dict(
            :date => round(now(), Base.Dates.Second),
            :level => args[:level],
            :levelnum => args[:levelnum],
            :msg => args[:msg],
            :name => args[:name],
            :pid => myid(),
            :lookup => isempty(trace) ? nothing : first(trace),
            :stacktrace => trace,
        ))
    end
end
