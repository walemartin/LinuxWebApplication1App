FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["LinuxWebApplication1App.csproj", "./"]
RUN dotnet restore "LinuxWebApplication1App.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "LinuxWebApplication1App.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "LinuxWebApplication1App.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LinuxWebApplication1App.dll"]
