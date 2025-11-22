# Верните ваш оригинальный .NET Dockerfile
cat > Dockerfile << 'EOF'
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY app-src/ExhibitionApp.sln .
COPY app-src/ExhibitionApp/*.csproj ./ExhibitionApp/
RUN dotnet restore
COPY app-src/ .
WORKDIR /src/ExhibitionApp
RUN dotnet publish -c Release -o /app/publish
FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
CMD ["dotnet", "ExhibitionApp.dll"]
EOF

git add Dockerfile
git commit -m "feat: restore .NET application Dockerfile"
git push origin main
