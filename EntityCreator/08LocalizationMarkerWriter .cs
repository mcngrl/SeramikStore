using System.Text;

public static class LocalizationMarkerWriter
{
    /// <summary>
    /// Generates localization marker class for an entity.
    /// Example:
    ///   PotansiyelResource.generated.cs
    /// </summary>
    public static string Generate(
        string localizationNamespace,
        string entity)
    {
        var sb = new StringBuilder();

        sb.AppendLine();
        sb.AppendLine($"namespace {localizationNamespace}");
        sb.AppendLine("{");
        sb.AppendLine($"    /// <summary>");
        sb.AppendLine($"    /// Localization marker class for {entity}");
        sb.AppendLine($"    /// Resource files:");
        sb.AppendLine($"    ///  - {entity}Resource.tr.resx");
        sb.AppendLine($"    ///  - {entity}Resource.en.resx");
        sb.AppendLine($"    /// </summary>");
        sb.AppendLine($"    public class {entity}Resource");
        sb.AppendLine("    {");
        sb.AppendLine("    }");
        sb.AppendLine("}");

        return sb.ToString();
    }


}
