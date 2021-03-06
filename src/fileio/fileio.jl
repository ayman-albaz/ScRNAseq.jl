module FileIO

using DelimitedFiles, MatrixMarket, MAT, CSV, DataFrames, HDF5
export readtxt,   # Text file   
	   readmtx,   # MatrixMarket file
	   readmat,   # MATLAB mat file
	   readhdf,   # HDF5 file
       readgenelist       


function readmtx(filename)
    # read MatrixMarket file
    X=mmread(filename);
end

function readcsv(filename)
    # read CSV file with header and row name
    df = CSV.File(filename; datarow=2) |> DataFrame!
    X=convert(Matrix, df[:,2:end])
    genelist=df[:,1]
    return X,genelist    
end

function readmat(filename)
    # read Matlab Mat file 
    file=matopen(filename)
    X=read(file,"X")
    genelist=read(file,"genelist")
    close(file)
    X = convert(Array{Float64,2}, X)
    return X,genelist
end

function readtxt(filename)
    # read DLM text file
    X=readdlm(filename,',',Int16)
end

function readhdf(filename)
    # https://anndata.readthedocs.io/en/latest/anndata.AnnData.html
end

function readgenelist(filename::String,colidx::Integer=1)
    # read genelist
    genelist=readdlm(filename,'\t',String)
    genelist=vec(genelist[:,colidx])
end

# using UnicodePlots
# function showx(X)
#    spy(X)
# end

end