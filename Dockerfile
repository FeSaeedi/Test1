FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY webapptest/*.csproj ./webapptest/
RUN dotnet restore

# copy everything else and build app
COPY webapptest/. ./webapptest/
WORKDIR /app/webapptest
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /app
COPY --from=build /app/webapptest/out ./
ENTRYPOINT ["dotnet", "webapptest.dll"]
