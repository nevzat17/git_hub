FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /source

COPY *.csproj .

RUN dotnet restore

COPY . .

RUN dotnet publish -c release -o /app --no-restore


# An image containing only runtime components
FROM mcr.microsoft.com/dotnet/aspnet:6.0      

WORKDIR /app

COPY --from=build /app . 

ENTRYPOINT ["dotnet", "MyApp.dll"]